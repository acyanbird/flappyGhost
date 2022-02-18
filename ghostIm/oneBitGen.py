from PIL import Image

def img2coe(name):
    img = Image.open(name)
    img = img.convert("1")

    width, height = img.size

    output_file = name.split('.')[0] + ".coe"

    f = open(output_file, "w")

    # using the 16, so change radix to 16, can be 2(binary), 10(decimal), 16(hex)

    f.write("memory_initialization_radix=2;\nmemory_initialization_vector=\n")

    for x in range(0, height):
        for y in range(0, width):
            pix = img.getpixel((y, x))
            if pix == 255:
                pix = 1
            pix = str(pix)
            pix += ",\n"
            f.write(pix)
    f.seek(f.tell() - 1, 0)  # put pointer to last position - 1, relative to head
    f.truncate()  # del final ,
    f.write(";")  # add ;



if __name__ == "__main__":
    name = input("Input image name:")
    img2coe(name)