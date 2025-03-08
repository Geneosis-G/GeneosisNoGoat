class NoScore extends NoMutatorBase;

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

	if(WorldInfo.Game.class == class'GGGameInfo')
	{
		RemoveScore();
	}
}

function RemoveScore()
{
	local int i;

	for(i=0 ; i<mGoats.Length ; i=i)
	{
		if(RemoveScoreForGoat(mGoats[i]))
		{
			mGoats.Remove(i, 1);
		}
		else
		{
			i++;
		}
	}
}

function bool RemoveScoreForGoat(GGGoat goat)
{
	local GGHUD localHUD;

	localHUD = GGHUD( GGPlayerControllerGame(goat.Controller).myHUD );
	if(localHUD != none && localHUD.mHUDMovie != none)
	{
		localHUD.mHUDMovie.mScoreWidget.mScoreLabel.SetVisible(false);
		localHUD.mHUDMovie.mScoreWidget.mTweenLabel.SetVisible(false);
		localHUD.mHUDMovie.mScoreWidget.SetVisible(false);
		localHUD.mHUDMovie.mComboWidget=none;
		//localHUD.mHUDMovie.mComboListLabel=none;
		localHUD.mHUDMovie.mComboListLabel.SetVisible(false);
		localHUD.mHUDMovie.mComboLegacyWidget=none;
		return true;
	}
	return false;
}

DefaultProperties
{}