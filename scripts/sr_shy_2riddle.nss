void main()
{
// Call to the Riddle
//   Answer is as follows
//   27 (two seven skies)
//   Minus 9 (takes nine lives) = 18
//   Doubled (twice as many) = 36
//   Remove the six (no six sense) = 3

    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    if (!iTripped) {
        SetLocalInt(OBJECT_SELF, "Tripped", TRUE);
        ActionStartConversation(GetEnteringObject(), "sr_shy1");
    }
}
