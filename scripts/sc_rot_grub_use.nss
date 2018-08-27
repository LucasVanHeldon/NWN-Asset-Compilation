void main() {
    object PC = GetLastUsedBy();
    if (GetLocalInt(OBJECT_SELF,"ROT_GRUB") == 0) {
        string name = GetName(OBJECT_SELF);
        int count = d20() + 2;
        string strCount = IntToString(count);
        SendMessageToPC(PC,"When you examine the " + name + ", " + strCount +
                           " rot grubs crawl onto your arm and start burrowing into your flesh.");
        SetCustomToken(1001,name);
        SetCustomToken(1002,strCount);
        PlayVoiceChat(VOICE_CHAT_CUSS, PC);
        BeginConversation("cv_rot_grub",PC);
        SetLocalInt(OBJECT_SELF,"ROT_GRUB",1);
        SetLocalInt(PC,"ROT_GRUB",1);
    }
}
