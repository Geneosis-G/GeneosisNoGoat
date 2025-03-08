class NoExperience extends NoMutatorBase;

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
	super.Tick( deltaTime );

	if(GGGameInfoMMO(WorldInfo.Game) != none)
	{
		RemoveExperience();
	}
}

function RemoveExperience()
{
	local int i;

	for(i=0 ; i<mGoats.Length ; i=i)
	{
		if(RemoveExperienceForGoat(mGoats[i]))
		{
			mGoats.Remove(i, 1);
		}
		else
		{
			i++;
		}
	}
}

function bool RemoveExperienceForGoat(GGGoat goat)
{
	local GGHUD localHUD;
	local GGGameInfoMMO mmoGame;
	local int i;

	mmoGame=GGGameInfoMMO(WorldInfo.Game);
	localHUD = GGHUDMMO( GGPlayerControllerGame(goat.Controller).myHUD );
	if(mmoGame != none && localHUD != none && localHUD.mHUDMovie != none)
	{
		for( i = 0; i < mmoGame.mComboManagers.Length; i++ )
		{
			if(GGComboManagerMMO(mmoGame.mComboManagers[i]) != none && mmoGame.mComboManagers[i].mGoatController == goat.Controller)
			{
				mmoGame.mComboManagers[i].SetOwnerController(none);
				break;
			}
		}
		GGHUDGfxIngameMMO( localHUD.mHUDMovie ).mExperienceBar.SetVisible(false);
		GGHUDGfxIngameMMO( localHUD.mHUDMovie ).mLevelUpLabel=none;
		return true;
	}
	return false;
}

DefaultProperties
{}