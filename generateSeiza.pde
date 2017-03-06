void setup() {
  size(960, 720);
  background(0);

  textAlign(CENTER);
  textSize(48);
  text("Left click: (re)generate\nRight click: save image", width/2, height/2);
}

void draw() {
}

void drawSeiza() {
  background(0);

  int datalen = 255; // numbber of data
  int margin = int(min(width, height)*0.05);
  int bigint = 114514893; // 値がでかい

  float[] dataX = new float[datalen]; //data-position X container
  float[] dataY = new float[datalen]; // data-position Y container

  float[][] dist = new float[datalen][datalen]; //distance-between-data container

  noStroke();
  ellipseMode(CENTER);
  for (int i=0; i<datalen; i++) { //initialize data-position
    dataX[i] = random( 0+margin, width-margin );
    dataY[i] = random( 0+margin, height-margin );
    ellipse(dataX[i], dataY[i], 5, 5);
  }


  for (int i=0; i<datalen; i++) {
    stroke(255);
    for (int j=0; j<datalen; j++) {
      dist[i][j]= dist(dataX[i], dataY[i], dataX[j], dataY[j]); // store distances
      //line(dataX[i], dataY[i], dataX[j], dataY[j]);
    }
    dist[i][i] = bigint; // exclude itself
  }

  for (int i=0; i<datalen; i++) {
    for (int j=0; j<datalen; j++) {
      if (dist[i][j] == min(dist[i])) { // draw line to nearest neighboor
        line(dataX[i], dataY[i], dataX[j], dataY[j]);
        if (dist[i][j] == min(dist[j])) { // dissolve isolated pairs
          dist[j][i] = bigint;
        }
        dist[i][j] = bigint;
        break;
      }
    }
  }
}


void mouseClicked() {
  if (mouseButton == RIGHT) {
  String date = str(year())+'-'+str(month())+'-'+str(day());
  String time = str(hour()*10000+minute()*100+second());
  String fname = date+'_'+ time + ".png" ;
  String dirname = "exports";
  save(dirname +"/"+ fname);
  } else {
    drawSeiza();
  }
}