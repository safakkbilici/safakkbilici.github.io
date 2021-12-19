import os, cv2
jpgs = [i for i in os.listdir(".") if i.split(".")[-1] == "jpg"]

for f in jpgs:
    img = cv2.cvtColor(cv2.imread(f), cv2.COLOR_BGR2RGB)	
    img = cv2.resize(img, (370, 499), interpolation = cv2.INTER_CUBIC)
    cv2.imwrite(f, img)

    
