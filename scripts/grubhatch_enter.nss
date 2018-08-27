void main()
{
    string      grubhatchery = GetTag(OBJECT_SELF);

    // do it once
    if (GetLocalInt(GetModule(),grubhatchery)==0)
    {
        SpeakOneLinerConversation("dscpt_grubhatch");
        // update variable
        SetLocalInt(GetModule(),GetTag(OBJECT_SELF),1);
    }
}
