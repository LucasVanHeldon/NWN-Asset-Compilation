/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.2

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Goes OnPerceived of a creature
void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
ActionSpeakString("What are ye doin' in my house!!!");

ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 10.0f);

}

