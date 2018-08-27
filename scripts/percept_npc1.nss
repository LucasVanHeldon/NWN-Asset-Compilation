
void main()
{
// * if not runnning normal or better Ai then exit for performance reasons
    // * if not runnning normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;
    object oPercep = GetLastPerceived();
    int bSeen = GetLastPerceptionSeen();
    int bHeard = GetLastPerceptionHeard();
     if(!GetIsPC(oPercep)) return;
     if (oPercep != OBJECT_INVALID)
         {
          if (bSeen)
             {
             ActionSpeakString("I can see you.");
             return;
              }
              if (bHeard)
                 {
                 ActionSpeakString("I can hear you.");
                 return;
                  }
          }
}





