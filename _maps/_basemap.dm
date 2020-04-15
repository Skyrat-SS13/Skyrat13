//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom_Skyrat.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Mining\Lavaland_Skyrat.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2_Skyrat.dmm"
		#include "map_files\MetaStation\MetaStation_Skyrat.dmm"
		#include "map_files\OmegaStation\OmegaStation_Skyrat.dmm"
		#include "map_files\PubbyStation\PubbyStation_Skyrat.dmm"
		#include "map_files\BoxStation\BoxStation_Skyrat.dmm"
		#include "map_files\LambdaStation\lambda_Skyrat.dmm"

		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
