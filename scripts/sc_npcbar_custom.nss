int evt;

void main() {
    evt = GetUserDefinedEventNumber();
    if (evt == 1001) {
        if (!IsInConversation(OBJECT_SELF)) {
            ActionSit(GetNearestObjectByTag("Chair",OBJECT_SELF));
        }
    }
}
