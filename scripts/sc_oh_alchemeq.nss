// If the kit finds itself NOT in a conversation, destroy it!
void main() {
    if (!IsInConversation(OBJECT_SELF)) AssignCommand(OBJECT_SELF, DelayCommand(0.5, DestroyObject(OBJECT_SELF)));
}
