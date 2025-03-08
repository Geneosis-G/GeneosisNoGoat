class NoRagdoll extends NoMutatorBase;

var array<GGGoat> mGoats;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	super.ModifyPlayer( other );
	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			mGoats.AddItem(goat);
		}
	}
}

event Tick( float deltaTime )
{
	local GGGoat goat;

	super.Tick( deltaTime );

	//WorldInfo.Game.Broadcast(self, "Ragdoll.mGoats.Length=" $ mGoats.Length);
	foreach mGoats(goat)
	{
		if(goat.mIsRagdoll)
		{
			goat.StandUp();
		}
		//WorldInfo.Game.Broadcast(self, goat $ " no ragdoll");
		goat.mIsRagdollAllowed=false;
	}
}

DefaultProperties
{}