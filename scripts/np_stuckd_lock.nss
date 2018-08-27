 void main()
{
 int iTrapTrigger = GetLocalInt(OBJECT_SELF, "TrapTrigger");
 if (iTrapTrigger == TRUE)
 {
  SetLocked(OBJECT_SELF, TRUE);
  SetLocalInt(OBJECT_SELF, "TrapTrigger", FALSE);
 }
}
