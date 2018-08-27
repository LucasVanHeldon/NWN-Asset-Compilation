void main()
{
    string      treachfloor = GetTag(OBJECT_SELF);

    // do it once
    if (GetLocalInt(GetModule(),treachfloor)==0)
    {
        SpeakOneLinerConversation("dscpt_treachfloo");
        // update variable
        SetLocalInt(GetModule(),GetTag(OBJECT_SELF),1);
    }
}
