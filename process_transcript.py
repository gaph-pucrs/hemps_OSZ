import re
import os
import matplotlib.pyplot as plt # type: ignore
from dataclasses import dataclass, field
from typing import List, Dict, Tuple

@dataclass
class HTStatus:
    """
    Representa o estado de um HT em um momento específico.
    """
    time: float  # Tempo em que o estado foi registrado (em ns)
    status: str  # Estado: 'enabled' ou 'disabled'

@dataclass
class HT:
    """
    Representa um HT (Host Terminal).
    """
    address: str  # Endereço do HT
    port: int  # Porta do HT
    type: str  # Tipo do HT
    status_history: List[HTStatus] = field(default_factory=list)  # Histórico de estados

    def update_status(self, time: float, status: str):
        """
        Atualiza o estado do HT no tempo especificado.
        """
        self.status_history.append(HTStatus(time, status))

    def calculate_disabled_period_mean(self) -> float:
        """
        Calcula a média dos períodos desabilitados.
        """
        disabled_periods = []
        sorted_history = sorted(self.status_history, key=lambda x: x.time)

        for i in range(len(sorted_history) - 1):
            if sorted_history[i].status == "disabled":
                duration = sorted_history[i + 1].time - sorted_history[i].time
                disabled_periods.append(duration)

        return sum(disabled_periods) / len(disabled_periods) if disabled_periods else 0

class HTManager:
    """
    Gerencia os HTs registrados.
    """
    def __init__(self):
        self.hts: Dict[Tuple[str, int], HT] = {}

    def process_line(self, line: str):
        """
        Processa uma linha do arquivo transcript para capturar informações de HTs.
        """
        pattern = (
            r"HT TYPE: (\S+) \| ADDRESS: (\S+) \| HT_PORT: (\d+) \| STATUS: (\S+) \| TIME: (\d+) ps"
        )
        match = re.search(pattern, line)
        if match:
            ht_type = match.group(1)
            address = match.group(2)
            port = int(match.group(3))
            status = match.group(4)
            time_ps = int(match.group(5))  # Tempo em ps
            time_ns = time_ps / 1_000  # Converte para ns

            key = (address, port)
            if key not in self.hts:
                # Cria um novo HT
                self.hts[key] = HT(address=address, port=port, type=ht_type)

            # Atualiza o status do HT
            self.hts[key].update_status(time_ns, status)

    def process_file(self, file_path: str):
        """
        Processa todas as linhas de um arquivo e registra os HTs e seus estados.
        """
        with open(file_path, 'r', encoding='utf-8') as file:
            for line in file:
                self.process_line(line)

    def list_all_hts(self) -> List[HT]:
        """
        Retorna a lista de todos os HTs registrados.
        """
        return list(self.hts.values())

    def plot_ht_timeline(self):
        """
        Gera um gráfico de barras mostrando o comportamento temporal dos HTs.
        """
        fig, ax = plt.subplots(figsize=(12, 6))
        colors = {"enabled": "orange", "disabled": "blue"}

        for idx, ht in enumerate(self.list_all_hts(), start=1):
            ht_name = f"{ht.address}:{ht.port}"
            sorted_history = sorted(ht.status_history, key=lambda x: x.time)

            # Calcula a média dos períodos desabilitados
            mean_disabled_period = ht.calculate_disabled_period_mean()

            for i in range(len(sorted_history) - 1):
                start_time = sorted_history[i].time
                end_time = sorted_history[i + 1].time
                status = sorted_history[i].status
                ax.barh(
                    y=ht_name,
                    width=end_time - start_time,
                    left=start_time,
                    height=0.4,
                    color=colors[status],
                    edgecolor="black",
                    linewidth=0.5,  # Linha preta mais fina
                    label=status if idx == 1 else None,  # Adiciona legenda apenas na primeira iteração
                )

            # Desenha o último período desabilitado
            if mean_disabled_period > 0:
                last_status = sorted_history[-1]
                if last_status.status == "disabled":
                    ax.barh(
                        y=ht_name,
                        width=mean_disabled_period,
                        left=last_status.time,
                        height=0.4,
                        color=colors["disabled"],
                        edgecolor="black",
                        linewidth=0.5,
                    )

        # Configurações do gráfico
        ax.set_xlabel("Tempo (ns)")
        ax.set_ylabel("HT (Address:Port)")
        ax.set_title("Comportamento Temporal dos HTs")
        ax.legend(["Enabled", "Disabled"], loc="upper right")
        plt.tight_layout()
        plt.show()

# Exemplo de uso
if __name__ == "__main__":
    manager = HTManager()
    transcript_file = "sandbox/paper_gustavo/cb_intermittent_size_10_delay_3_payload_50/transcript"  # Nome do arquivo a ser processado

    try:
        # Processa o arquivo de transcript
        manager.process_file(transcript_file)

        # Mostra as informações de todos os HTs processados
        print("\n[INFO] HTs Processados:")
        for ht in manager.list_all_hts():
            print(f"HT Address: {ht.address}, Port: {ht.port}, Type: {ht.type}")
            for status in ht.status_history:
                print(f"  Time: {status.time:.2f} ns, Status: {status.status}")
            print("-" * 40)  # Linha divisória entre HTs

        # Gera o gráfico de comportamento temporal
        manager.plot_ht_timeline()

    except FileNotFoundError:
        print(f"Erro: O arquivo '{transcript_file}' não foi encontrado.")
    except Exception as e:
        print(f"Erro ao processar o arquivo: {e}")
