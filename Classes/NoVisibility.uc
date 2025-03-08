class NoVisibility extends GGMutator;

var array< class<NoMutatorBase> > mVisibilityInfos;
var int mIndex;

function ModifyPlayer(Pawn Other)
{
	super.ModifyPlayer( other );

	GGPlayerInput( PlayerController(Other.Controller).PlayerInput ).RegisterKeyStateListner( KeyState );
	RegisterAllNoMutators();
}

function KeyState( name newKey, EKeyState keyState, PlayerController PCOwner )
{
	local GGPlayerInputGame localInput;

	localInput = GGPlayerInputGame( PCOwner.PlayerInput );

	if( keyState == KS_Down )
	{
		if(localInput.IsKeyIsPressed("LeftMouseButton", string( newKey )) || newKey == 'XboxTypeS_RightTrigger')
		{
			ToggleVisibility();
		}
		if(localInput.IsKeyIsPressed("RightMouseButton", string( newKey ))|| newKey == 'XboxTypeS_LeftTrigger')
		{
			GetNextMut();
		}
		AddHint(PCOwner);
	}
}

function AddHint(PlayerController PC)
{
	local string completeString;
	local GGPlayerInputGame pInput;

	if(PC == none)
		return;

	pInput = GGPlayerInputGame(PC.PlayerInput );

	completestring=pInput.GetKeyFromCommand("GBA_AbilityAuto") $ " to change visibility | " $ pInput.GetKeyFromCommand("GBA_FreeLook") $ " to change mutator";

	GGPlayerControllerGame( PC ).AddHintLabelMessage( "NOVISIBILITY", completeString, 0 );
}

function RegisterAllNoMutators()
{
	if(mVisibilityInfos.Length > 0)// Already registered
		return;

	RegisterNoMutator(class'NoAngel');
	RegisterNoMutator(class'NoBaaa');
	RegisterNoMutator(class'NoBalance');
	RegisterNoMutator(class'NoChat');
	RegisterNoMutator(class'NoExperience');
	RegisterNoMutator(class'NoFire');
	RegisterNoMutator(class'NoFlips');
	RegisterNoMutator(class'NoGoat');
	RegisterNoMutator(class'NoManual');
	RegisterNoMutator(class'NoMusic');
	//RegisterNoMutator(class'NoMutation');
	RegisterNoMutator(class'NoRagdoll');
	RegisterNoMutator(class'NoScore');
	RegisterNoMutator(class'NoSFX');
	RegisterNoMutator(class'NoSkin');
	RegisterNoMutator(class'NoVoices');
	RegisterNoMutator(class'NoZombie');
}

function RegisterNoMutator(class<NoMutatorBase> mutClass)
{
	mVisibilityInfos.AddItem(mutClass);
}

function GetNextMut()
{
	if(mVisibilityInfos.Length == 0)
		return;

	mIndex++;
	if(mIndex >= mVisibilityInfos.Length)
	{
		mIndex=0;
	}
	WorldInfo.Game.Broadcast(self, mVisibilityInfos[mIndex].static.GetName() @ "(" $ (mVisibilityInfos[mIndex].static.IsVisible()?"visible":"hidden") $ ")");
}

function ToggleVisibility()
{
	if(mVisibilityInfos.Length == 0)
		return;

	mVisibilityInfos[mIndex].static.SetVisible(!mVisibilityInfos[mIndex].static.IsVisible());
	WorldInfo.Game.Broadcast(self, mVisibilityInfos[mIndex].static.GetName() @ "is now" @ (mVisibilityInfos[mIndex].static.IsVisible()?"visible":"hidden"));
}

DefaultProperties
{

}