# from sys import argv
import sys

if len(sys.argv) == 2:
	scriptname,backtrack_word = sys.argv
	# backtrack_word = str(backtrack_word)
	print ("backtrack_word: " + backtrack_word)
else:
	print ("usage:")
	print ("	read_bactrack.py <backtrack word in hexa>")
	print ("	ex: read_bactrack.py 157F157F")
	exit();

print ("backtrack lenght: %d" % len(backtrack_word))

for i in xrange(0,len(backtrack_word)):
# for i in range(len(backtrack_word)-1,0,-1):
	# print backtrack_word[i],
	if backtrack_word[i] == '0'									: sys.stdout.write('EE')
	elif backtrack_word[i] == '1'								: sys.stdout.write('EW')
	elif backtrack_word[i] == '2'								: sys.stdout.write('EN')
	elif backtrack_word[i] == '3'								: sys.stdout.write('ES')
	elif backtrack_word[i] == '4'								: sys.stdout.write('WE')
	elif backtrack_word[i] == '5'								: sys.stdout.write('WW')
	elif backtrack_word[i] == '6'								: sys.stdout.write('WN')
	elif backtrack_word[i] == '7'								: sys.stdout.write('WS')
	elif backtrack_word[i] == '8'								: sys.stdout.write('NE')
	elif backtrack_word[i] == '9'								: sys.stdout.write('NW')
	elif backtrack_word[i] == 'a' or backtrack_word[i] == 'A'	: sys.stdout.write('NN')
	elif backtrack_word[i] == 'b' or backtrack_word[i] == 'B'	: sys.stdout.write('NS')
	elif backtrack_word[i] == 'c' or backtrack_word[i] == 'C'	: sys.stdout.write('SE')
	elif backtrack_word[i] == 'd' or backtrack_word[i] == 'D'	: sys.stdout.write('SW')
	elif backtrack_word[i] == 'e' or backtrack_word[i] == 'E'	: sys.stdout.write('SN')
	elif backtrack_word[i] == 'f' or backtrack_word[i] == 'F'	: sys.stdout.write('SS')
	else														: sys.stdout.write('--')
sys.stdout.write('\n')
