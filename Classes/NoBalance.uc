class NoBalance extends NoMutatorBase;

var array<GGGoat> mGoats;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			mGoats.AddItem(goat);
		}
	}
	super.ModifyPlayer( other );
}

event Tick( float deltaTime )
{
	local GGGoat goat;
	local GGBicycleAbstract bike;

	super.Tick( deltaTime );

	//WorldInfo.Game.Broadcast(self, "Manual.mGoats.Length=" $ mGoats.Length);
	foreach mGoats(goat)
	{
		bike = GGBicycleAbstract(goat.DrivenVehicle);
		//WorldInfo.Game.Broadcast(self, goat @ goat.DrivenVehicle @ bike.mLostBalance);
		if(bike != none && bike.mLostBalance)
		{
			bike.FinishBalancing();
			bike.mAnimBlendNode.SetBlendTarget( 0.5f, 0.05f );
			bike.mFallDir = EFallDirection( ( int( bike.mFallDir ) + 1 ) % FD_LAST_ENUM );
		}
		/*if(bike != none && bike.mAnimBlendNode != none)
		{
			bike.FinishBalancing();
			bike.mAnimBlendNode.SetBlendTarget( 0.5f, 0.05f );
			bike.mFallDir = EFallDirection( ( int( bike.mFallDir ) + 1 ) % FD_LAST_ENUM );
			bike.mAnimBlendNode = none;
		}*/
	}
}

DefaultProperties
{}