//:://////////////////////////////////////////////
//:: Created By: Oraweb
//:: Created On: 2003
//:://////////////////////////////////////////////
object PC;
effect eEffect;

void main() {
    PC = GetExitingObject();
    eEffect = GetFirstEffect(PC);
    while (GetIsEffectValid(eEffect)) {
        if (GetEffectCreator(eEffect) == OBJECT_SELF) {
            RemoveEffect(PC, eEffect);
        }
        eEffect = GetNextEffect(PC);
    }
}
