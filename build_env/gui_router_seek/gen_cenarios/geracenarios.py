#!/usr/bin/python3
import sys
import subprocess
import os

global body,apps
fb=open("test.yaml")
body=fb.read()
fa=open("apps.yaml")
apps=fa.read()
YES=True
NO=False
class App:
	def __init__(self,prod,cons,time=0,secure=False) -> None:
		self.prod=prod
		self.cons=cons
		self.time=time
		self.secure=secure
	sec = lambda self:"yes" if self.secure else "no"
	def get_val(self):
		return (*self.prod,*self.cons,self.time,self.sec())
	def format_name(self):
		return "__p{}x{}_c{}x{}_{}ms_{}".format(*self.get_val())
	def gen_string(self):
		global apps
		return apps.format(*self.get_val())
	def __repr__(self) -> str:
		return self.gen_string()
	def __str__(self) -> str:
		return self.gen_string()
class Cenario:
	def __init__(self,id:int,size:tuple[int,int],apps:App=[],time:int=40):
		self.size=size
		self.apps=apps
		self.time=time
		self.id=id
	def add_app(self,app):
		self.apps.append(app)
	def set_apps(self,apps):
		self.apps=apps
	def gen_string(self):
		global body, apps
		s=body.format(*self.size)
		f=os.getenv("HEMPS_PATH")
		f+="/testcases/examples/cen{}_{}x{}".format(self.id,*self.size)
		for a in self.apps:
			s+=a.gen_string()
			f+=a.format_name()
		self.folder=f
		self.file_name=f+".yaml"
		return s
	def __repr__(self) -> str:
		return self.gen_string()
	def __str__(self) -> str:
		return self.gen_string()
	def save_to_disk(self):
		s=self.gen_string()
		f=open(self.file_name,mode='w')
		f.write(s)
		f.close()
	def run(self):
		# subprocess.run(f"rm {self.folder} -rI -Y")
		# err=open(f"{self.folder}.err","w")
		# out=open(f"{self.folder}.log","w")
		subprocess.call(f"hemps-run {self.file_name} {self.time} 2> {self.folder}.err 1> {self.folder}.log", shell=True,env=os.environ)#, stderr=err,stdout=out)		# err.close()
		# out.close()
def run_test(cenarios:dict[Cenario],apps_cen:dict[App],cen:int):
	for c in cenarios[cen]:
		for a in apps_cen[cen]:
			c.set_apps(a)
			c.save_to_disk()
			c.run()
def main():
	
	cenarios=dict()
	apps_cen=dict()

	apps_cen.update({2:[]})
	apps_cen[2].append([App((1,1),(2,2),0,True),App((0,1),(0,2),0,False)])


	cenarios.update({2:[]})
	#TESTE 2
	cenarios[2].append(Cenario(2,(3,3)))
	cenarios[2].append(Cenario(2,(4,4)))
	cenarios[2].append(Cenario(2,(5,5)))
	cenarios[2].append(Cenario(2,(6,6)))


	# # TESTE 3
	apps_cen.update({3:[]})
	apps_cen[3].append([App((2,2),(2,3),0,YES), App((0,1),(3,1),0,NO),App((4,1),(4,3),0,NO),App((0,3),(4,4),1,NO)])
	apps_cen[3].append([App((2,2),(2,3),0,YES),App((0,1),(3,1),0,YES),App((4,1),(4,3),0,NO),App((0,3),(4,4),1,NO)])
	apps_cen[3].append([App((2,2),(2,3),0,YES),App((0,1),(3,1),0,YES),App((4,1),(4,3),0,YES),App((0,3),(4,4),1,NO)])
	apps_cen[3].append([App((2,2),(2,3),0,YES),App((0,1),(3,1),0,YES),App((4,1),(4,3),0,YES),App((0,3),(4,4),1,YES)])

	cenarios.update({3:[]})
	cenarios[3].append(Cenario(3,(5,5)))
	# # TESTE 4
	apps_cen.update({4:[]})
	apps_cen[4].append([App((0,3),(4,4),0,NO),App((2,2),(2,3),1,YES),App((1,1),(4,0),0,NO),App((3,0),(4,1),0,NO)])
	apps_cen[4].append([App((0,3),(4,3),0,NO),App((2,2),(2,3),1,YES),App((1,1),(4,0),0,NO),App((3,0),(4,1),0,NO)])
	apps_cen[4].append([App((0,3),(4,3),0,NO),App((2,2),(2,3),1,YES),App((1,1),(4,2),0,NO),App((3,0),(4,1),0,NO)])
	apps_cen[4].append([App((0,3),(4,3),0,NO),App((2,2),(2,3),1,YES),App((0,2),(4,0),0,NO),App((3,0),(4,4),0,NO)])
	cenarios.update({4:[]})
	cenarios[4].append(Cenario(4,(5,5)))

	run_test(cenarios,apps_cen,2)
	run_test(cenarios,apps_cen,3)
	run_test(cenarios,apps_cen,4)
if __name__=="__main__":
	main()