class NoMutation extends NoMutatorBase;

var bool mMutatorsDisabled;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			if(!mMutatorsDisabled)
			{
				//SetTimer(1.f, false, NameOf(DisableMutators));
				DisableMutators();
				mMutatorsDisabled = true;
			}
		}
	}
	super.ModifyPlayer( other );
}

function DisableMutators()
{
	local GGSeqAct seqact;
	local array<GGSeqAct> seqactList;

	//seqact = GGSeqAct(FindObject("Attach Deadgoa7", class'GGSeqAct_AttachGoatmau5'));
	//WorldInfo.Game.Broadcast(self, "seqact1=" $ seqact @ seqact.name);

	//seqact = GGSeqAct(FindObject("GGSeqAct_AttachGoatmau5_0", class'GGSeqAct_AttachGoatmau5'));
	//WorldInfo.Game.Broadcast(self, "seqact2=" $ seqact @ seqact.name);

	//seqact = GGSeqAct_AttachGoatmau5(FindObject(class'GGSeqAct_AttachGoatmau5'.Outer $ ".Default__GGSeqAct_AttachGoatmau5", class'GGSeqAct_AttachGoatmau5'));
	//WorldInfo.Game.Broadcast(self, "seqact3=" $ seqact @ seqact.name);

	//WorldInfo.Game.Broadcast(self, "WorldInfo=" $ WorldInfo @ WorldInfo.name);

	seqactList.AddItem(GGSeqAct_AttachGoatmau5(FindObject(class'GGSeqAct_AttachGoatmau5'.Outer $ ".Default__GGSeqAct_AttachGoatmau5", class'GGSeqAct_AttachGoatmau5')));

	foreach seqactList(seqact)
	{
		if(seqact != none)
		{
			seqact.bAutoActivateOutputLinks=false;
		}
	}
}

DefaultProperties
{}