from PIL import Image


def to16(r, g, b):
    # get decimal and return first 4 bits in hex
    outC = '\n'  # output string
    for num in [r, g, b]:
        num = '{:08d}'.format(int(bin(num)[2:]))[:4]  # firstly turn into bin, then get rid of 0b, put into 8 digits, get first 4
        num = hex(int(num, 2))[-1]  # turn into hex, get rid of 0x
        outC += str(num)
    outC += ','
    return outC

def img2coe(name):
    img = Image.open(name)
    img = img.convert("RGB")  # convert to RGB

    width, height = img.size

    output_file = name.split('.')[0] + ".coe"

    f = open(output_file, "w")

    # using the 16, so change radix to 16, can be 2(binary), 10(decimal), 16(hex)

    f.write("memory_initialization_radix=16;\nmemory_initialization_vector=")

    for x in range(0, height):
        for y in range(0, width):
            r, g, b = img.getpixel((y, x))
            line = to16(r, g, b)
            f.write(line)
    f.seek(f.tell() - 1, 0)  # put pointer to last position - 1, relative to head
    f.truncate()  # del final ,
    f.write(";")  # add ;

    # for line in arr:
    #     for r, g, b in line:
    #         r = int((r * 16) / 256)
    #         g = int((g * 16) / 256)
    #         b = int((b * 16) / 256)
    #         f.write(str('\n{:04b}'.format(r)) + str('{:04b}'.format(g)) + str('{:04b}'.format(b)) + ",")
    #         # 宽度是 4，用 0 填充
    # f.seek(f.tell() - 1, os.SEEK_SET)
    # f.truncate()
    # f.write(";")


if __name__ == "__main__":
    name = input("Input image name:")
    img2coe(name)
    # else:
    #     print("Insert at least one image path\nFormat: python img2coe.py <path>")
