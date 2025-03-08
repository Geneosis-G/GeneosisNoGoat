class NoSkin extends NoMutatorBase;

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
			ClearTimer(NameOf(ChangeSkins));
			SetTimer(1.5f, false, NameOf(ChangeSkins));
		}
	}

	super.ModifyPlayer( other );
}

function ChangeSkins()
{
	local GGGoat goat;

	foreach mGoats(goat)
	{
		ChangeGoatSkin(goat);
	}
	mGoats.Length=0;
}

function ChangeGoatSkin(GGGoat goat)
{
	local float mNewCollisionHeight, mNewCollisionRadius;

	goat.mesh.SetSkeletalMesh( class'GGGoat'.default.mesh.SkeletalMesh );
	goat.mesh.SetPhysicsAsset( class'GGGoat'.default.mesh.PhysicsAsset );
	goat.mesh.AnimSets[0] = class'GGGoat'.default.mesh.AnimSets[0];
	goat.mesh.SetAnimTreeTemplate( class'GGGoat'.default.mesh.AnimTreeTemplate );

	mNewCollisionHeight=class'GGGoat'.default.CylinderComponent.CollisionHeight;
	mNewCollisionRadius=class'GGGoat'.default.CylinderComponent.CollisionRadius;
	goat.SetLocation( goat.Location + vect( 0.0f, 0.0f, 1.0f ) * ( mNewCollisionHeight - goat.GetCollisionHeight() ) );
	goat.SetCollisionSize( mNewCollisionRadius, mNewCollisionHeight );

	goat.mCameraLookAtOffset = class'GGGoat'.default.mCameraLookAtOffset;

	goat.mNeckBoneName = class'GGGoat'.default.mNeckBoneName;
	goat.mFreeFallAnim = class'GGGoat'.default.mFreeFallAnim;

	goat.mDriverPosOffsetX = class'GGGoat'.default.mDriverPosOffsetX;
	goat.mDriverPosOffsetZ = class'GGGoat'.default.mDriverPosOffsetZ;
	goat.VehicleCheckRadius = class'GGGoat'.default.VehicleCheckRadius;

 	goat.mBoneScaleInfos = class'GGGoat'.default.mBoneScaleInfos;

 	goat.FetchTongueControl();
}

DefaultProperties
{}