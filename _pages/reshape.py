import cv2
import glob
from PIL import Image

for idx,f in enumerate(sorted(glob.glob("*.jpg"))):
    print(f)
    img = cv2.imread(f)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img = cv2.resize(img, (370, 499), interpolation = cv2.INTER_CUBIC)
    Image.fromarray(img).save(str(idx+1) + ".jpg")

    #cv2.imwrite(str(idx) + ".jpg", img)

