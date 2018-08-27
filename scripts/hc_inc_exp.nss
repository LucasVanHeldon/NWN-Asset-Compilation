// sr6.0
// new table that uses DMG numbers for xp.

int UseXPTable(int nBaseExp, float fCR, int nLevel)
{

   int nCR;
   int nExp;
   nCR = FloatToInt(fCR);
   float fPow;
   if (nCR > 20)
      fPow = (fCR - 19.0);
   if (nCR <= 1){
        if (nLevel >= 1 &&
            nLevel <= 6)
            nExp = nBaseExp;
        else if (nLevel == 7)
            nExp = FloatToInt(nBaseExp * 0.8767);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 0.6667);
        else nExp =  0;
      }
      else if (nCR == 2){
        if (nLevel >= 1 &&
            nLevel <= 4)
            nExp =  nBaseExp * 2;
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 1.6667);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 1.3134);
        else if (nLevel == 8)
            nExp =  nBaseExp;
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 0.75);
        else nExp =  0;
      }
      else if (nCR == 3){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 2.6667);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 2.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 1.75);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 1.1267);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 0.8334);
        else nExp =  0;
      }
      else if (nCR == 4){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 3.3334);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 2.3334);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 2.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 1.6867);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 1.25);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 0.9167);
        else nExp =  0;
      }
      else if (nCR == 5){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 5.3334);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 3.5);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 2.6667);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 2.25);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 1.8767);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 1.3767);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 1.0);
        else nExp =  0;
      }
      else if (nCR == 6){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 7.5);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 4.6667);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 2.0634);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 1.0834);
        else nExp =  0;
      }
      else if (nCR == 7){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 10.6667);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 7.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 5.3334);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 3.3334);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 2.75);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 2.25);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 1.6267);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 1.1667);
        else nExp =  0;
      }
      else if (nCR == 8){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 10.5);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 3.6667);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 2.4367);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 1.75);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 1.25);
        else nExp =  0;
      }
      else if (nCR == 9){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 21.3334);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 20.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 6.6667);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 5.5);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 3.25);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 2.6267);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 1.8767);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 1.3334);
        else nExp =  0;
      }
      else if (nCR == 10){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 21.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 13.5);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 7.3334);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 4.3334);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 3.5);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 2.8134);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 2.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 1.4167);
        else nExp =  0;
      }
      else if (nCR == 11){
        if (nLevel >= 1 &&
            nLevel <= 4)
            nExp =  FloatToInt(nBaseExp * 42.6667);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 28.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 11.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 6.5);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 4.6667);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 3.75);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 2.1267);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else nExp =  0;
      }
      else if (nCR == 12){
        if (nLevel >= 1 &&
            nLevel <= 5)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 42.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 27.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 20.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 16.5);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 8.6667);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 7.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 3.1867);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 2.25);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 1.5834);
        else nExp =  0;
      }
      else if (nCR == 13){
        if (nLevel >= 1 &&
            nLevel <= 6)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 56.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 22.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 13.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 9.3334);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 7.5);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 5.3334);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 4.25);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 3.3767);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 2.3767);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 1.6667);
        else nExp =  0;
      }
      else if (nCR == 14){
        if (nLevel >= 1 &&
            nLevel <= 7)
            nExp =  FloatToInt(nBaseExp * 84.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 33.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 19.5);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 5.6667);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 3.5634);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else nExp =  0;
      }
      else if (nCR == 14){
        if (nLevel >= 1 &&
            nLevel <= 7)
            nExp =  FloatToInt(nBaseExp * 84.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 33.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 19.5);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 5.6667);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 3.5634);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else nExp =  0;
      }
      else if (nCR == 15){
        if (nLevel >= 1 &&
            nLevel <= 8)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 44.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 26.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 21.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 10.6667);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 8.5);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 4.75);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 3.3334);
        else nExp =  0;
      }
      else if (nCR == 16){
        if (nLevel >= 1 &&
            nLevel <= 9)
            nExp =  FloatToInt(nBaseExp * 108.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 80.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 66.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 39.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 28.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 22.5);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 11.3334);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 6.3334);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else nExp =  0;
      }
      else if (nCR == 17){
        if (nLevel >= 1 &&
            nLevel <= 10)
            nExp =  FloatToInt(nBaseExp * 120.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 88.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 52.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 42.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 17.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 9.5);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 6.6667);
        else nExp =  0;
      }
      else if (nCR == 18){
        if (nLevel >= 1 &&
            nLevel <= 11)
            nExp =  FloatToInt(nBaseExp * 132.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 78.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 45.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 25.5);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 12.6667);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else nExp =  0;
      }
      else if (nCR == 19){
        if (nLevel >= 1 &&
            nLevel <= 12)
            nExp =  FloatToInt(nBaseExp * 144.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 104.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 84.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 34.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 27.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 19.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 13.3334);
        else nExp =  0;
      }
      else if (nCR == 20){
        if (nLevel >= 1 &&
            nLevel <= 13)
            nExp =  FloatToInt(nBaseExp * 156.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 112.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 90.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 51.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 28.5);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 20.0);
        else nExp =  0;
      }
      else if (nCR > 20 && IntToFloat(nCR)/2.0 != IntToFloat(nCR/2)){
        if (nLevel >= 1 &&
            nLevel <= 12)
            nExp =  FloatToInt((nBaseExp * 144.0) * fPow);
        else if (nLevel == 13)
            nExp =  FloatToInt((nBaseExp * 104.0) * fPow);
        else if (nLevel == 14)
            nExp =  FloatToInt((nBaseExp * 84.0) * fPow);
        else if (nLevel == 15)
            nExp =  FloatToInt((nBaseExp * 60.0) * fPow);
        else if (nLevel == 16)
            nExp =  FloatToInt((nBaseExp * 48.0) * fPow);
        else if (nLevel == 17)
            nExp =  FloatToInt((nBaseExp * 34.0) * fPow);
        else if (nLevel == 18)
            nExp =  FloatToInt((nBaseExp * 27.0) * fPow);
        else if (nLevel == 19)
            nExp =  FloatToInt((nBaseExp * 19.0) * fPow);
        else if (nLevel == 20)
            nExp =  FloatToInt((nBaseExp * 13.3334) * fPow);
        else nExp =  0;
      }
      else if (nCR > 20){
        if (nLevel >= 1 &&
            nLevel <= 13)
            nExp =  FloatToInt((nBaseExp * 156.0) * fPow);
        else if (nLevel == 14)
            nExp =  FloatToInt((nBaseExp * 112.0) * fPow);
        else if (nLevel == 15)
            nExp =  FloatToInt((nBaseExp * 90.0) * fPow);
        else if (nLevel == 16)
            nExp =  FloatToInt((nBaseExp * 64.0) * fPow);
        else if (nLevel == 17)
            nExp =  FloatToInt((nBaseExp * 51.0) * fPow);
        else if (nLevel == 18)
            nExp =  FloatToInt((nBaseExp * 36.0) * fPow);
        else if (nLevel == 19)
            nExp =  FloatToInt((nBaseExp * 28.5) * fPow);
        else if (nLevel == 20)
            nExp =  FloatToInt((nBaseExp * 20.0) * fPow);
        else nExp =  0;
      }
      else nExp = 0;

   return nExp;
}



