import Image
import ImageFont
import ImageDraw
from sys import argv

if len(argv) > 1 and len(argv) < 4:
	scriptname,X,Y = argv
	filename="output.png"
	X=int(X)
	Y=int(Y)
elif len(argv) > 1 and len(argv) < 5:
	scriptname,X,Y,filename = argv
	# print "scriptname:", scriptname
	# print "X:", X
	# print "Y:", Y
	# print "filename:", filename
	X=int(X)
	Y=int(Y)
else:
	print ("usage:")
	print ("MC_generator.py X_size Y_size <outputname.png>")
	X=5
	Y=4
	filename="output.png"

img_x_size=100
img_y_size=100

NEW_IMG_Y=Y*img_y_size
NEW_IMG_X=X*img_x_size

#opens an image:
im = Image.open("square.jpg")
#creates a new empty image, RGB mode to the many core size
new_im = Image.new('RGB', (NEW_IMG_X,NEW_IMG_Y))

#Here I resize my opened image, so it is no bigger than img_x_size,img_y_size
im.thumbnail((img_x_size,img_y_size))

#Iterate through a X by Y grid with img_x_size spacing, to place my image
for i in xrange(0,(X+1)*img_x_size,img_x_size):
	for j in xrange(0,(Y+1)*img_y_size,img_y_size):
		#I change brightness of the images, just to emphasise they are unique copies.
		# im=Image.eval(im,lambda x: x+(i+j)/30)

		#paste the image at location i,j:
		new_im.paste(im, (i,j))

#opens image to put the text
draw = ImageDraw.Draw(new_im)

#setting text font
font = ImageFont.truetype("/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-R.ttf", 16)

#Iterate through a X by Y grid with img_x_size spacing, to place the text
for i in xrange(10,(X+1)*img_x_size,img_x_size):
	for j in xrange(0,(Y+1)*img_y_size,img_y_size):

		#sets the X Y position of PE in the text
		text = "%d %d" % (i/img_x_size,Y-(1+j/img_y_size))
		draw.text((i, j),text,(0,0,0),font=font)

POSX=0.8*img_x_size
POSY=0.2*img_y_size
k=0
#Iterate through a X by Y grid with img_x_size spacing, to place my image
for j in xrange(0, Y):
	for i in xrange(0,X):

		#sets absolute position of PE in the text
		text = "%2d" % k
		draw.text((img_x_size*i+POSX,NEW_IMG_Y-img_y_size*j-POSY),text,(0,0,0),font=font)
		k=k+1

#insert text in image
draw = ImageDraw.Draw(new_im)

new_im.save(filename)
# new_im.show()

