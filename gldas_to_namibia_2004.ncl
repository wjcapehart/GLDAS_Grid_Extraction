

begin


   ;;;;;;;;;;;;;;;;;;;;;





    start_lat = -30.
    end_lat   = -15.
    start_lon =  10.
    end_lon   =  26.

    fileout_name = "Namibia_GLDAS_3hr_2004-01-01__2004-12-31.nc"
;;;;;;;; sets dates and times ;;;;;;;;;;;;;;;;;;

   start_time          = 0
      start_time@units = "hours since 2004-01-01 00:00:00" ;change the start date to first file start day
   end_time            = 3
      end_time@units   = "hours since 2004-12-31 21:00:00" ; change to last day of data

   assessed_time_interval   = 3		;interval between model data
      assessed_time_interval@units = "hours"

   archived_time_interval = 3		;interval between model data
      archived_time_interval@units = "hours"

   print(start_time)
   print(end_time)


      archived_units = "hours since 2000-01-01 00:00:00" ;change the start date to first file start day

   start_time_in_first_time_units = doubletointeger(ut_convert(start_time, archived_units))
      start_time_in_first_time_units@units = archived_units

   end_time_in_first_time_units = doubletointeger(ut_convert(end_time, archived_units))
      end_time_in_first_time_units@units = archived_units

   assessed_time  = ( ispan(start_time_in_first_time_units, end_time_in_first_time_units, assessed_time_interval)) ;creates array
      assessed_time@units = archived_units

    time =  ( ispan(start_time_in_first_time_units, end_time_in_first_time_units, assessed_time_interval))
      time@units = archived_units
      time!0     = "time"
       time&time     = time
     time@long_name = "time"
      time@standard_name = "time"
      time@description = "time"



   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




   ;;;;;;;;;;;;;;; file management  ;;;;;;;;;;;;;;;

   data_dir              = "/data/NCAR/GLDAS/nasa_raw_files/"
   data_file             = "gldas_noah_025_f_2015-01-01-00.grib1"
   demo_file_for_lat_lon = "/data/NCAR/GLDAS/nasa_raw_files/2016/GLDAS_NOAH025_3H.A20160530.0600.021.nc4"


    f         = addfile(demo_file_for_lat_lon,"r")

    longitude = f->lon({start_lon:end_lon})
    latitude = f->lat({start_lat:end_lat})

    depth_of_soil_layer_top    = (/ 0., 10., 40., 100. /)
    depth_of_soil_layer_bottom = (/ 10., 40., 100., 200. /)
    depth_of_soil_layer = (/ 5., 25., 70., 150. /)

    depth_of_soil_layer!0                          = "depth_of_soil_layer"
    depth_of_soil_layer&depth_of_soil_layer         = depth_of_soil_layer
    depth_of_soil_layer@description                = "Depth to Center of Soil Layer"
    depth_of_soil_layer@long_name                  = "Depth to Center of Soil Layer"
    depth_of_soil_layer@standard_name              = "depth"
    depth_of_soil_layer@depth_of_soil_layer_top    = depth_of_soil_layer_top
    depth_of_soil_layer@depth_of_soil_layer_center = depth_of_soil_layer
    depth_of_soil_layer@depth_of_soil_layer_bottom = depth_of_soil_layer_bottom
    depth_of_soil_layer@positive                   = "down"

    longitude!0 = "longitude"
    latitude!0  = "latitude"

    longitude@long_name     = "longitude"
    longitude@description   = longitude@long_name
    longitude@units         = "degrees_east"
    longitude@standard_name = "longitude"
    longitude&longitude     = longitude

    latitude@long_name     = "latitude"
    latitude@description   = latitude@long_name
    latitude@units         = "degrees_north"
    latitude@standard_name = "latitude"
    latitude&latitude      = latitude


    nlon  = dimsizes(longitude)
    nlat  = dimsizes(latitude)
    ntime = dimsizes(time)


    Swnet_tavg           = new( (/ ntime, nlat, nlon  /)   ,  float)
    Swnet_tavg!0         = "time"
    Swnet_tavg!1         = "latitude"
    Swnet_tavg!2         = "longitude"
    Swnet_tavg&time      = time
    Swnet_tavg&latitude  = latitude
    Swnet_tavg&longitude = longitude


    Lwnet_tavg     = Swnet_tavg
    SWdown_f_tavg  = Swnet_tavg
    LWdown_f_tavg  = Swnet_tavg
    Qle_tavg       = Swnet_tavg
    Qh_tavg        = Swnet_tavg
    Qg_tavg        = Swnet_tavg
    Snowf_tavg     = Swnet_tavg
    Rainf_tavg     = Swnet_tavg
    Evap_tavg      = Swnet_tavg
    AvgSurfT_inst  = Swnet_tavg
    Albedo_inst    = Swnet_tavg
    SWE_inst       = Swnet_tavg
    SnowDepth_inst = Swnet_tavg
    PotEvap_tavg   = Swnet_tavg
    ECanop_tavg    = Swnet_tavg
    Tveg_tavg      = Swnet_tavg
    ESoil_tavg     = Swnet_tavg
    RootMoist_inst = Swnet_tavg
    CanopInt_inst  = Swnet_tavg
    Wind_f_inst    = Swnet_tavg
    Rainf_f_tavg   = Swnet_tavg
    Tair_f_inst    = Swnet_tavg
    Qair_f_inst    = Swnet_tavg
    Psurf_f_inst   = Swnet_tavg
    Qs_acc         = Swnet_tavg
    Qsb_acc        = Swnet_tavg
    Qsm_acc        = Swnet_tavg




    copy_VarAtts(f->Swnet_tavg,     Swnet_tavg)
    copy_VarAtts(f->Lwnet_tavg,     Lwnet_tavg)
    copy_VarAtts(f->SWdown_f_tavg,  SWdown_f_tavg)
    copy_VarAtts(f->LWdown_f_tavg,  LWdown_f_tavg)
    copy_VarAtts(f->Qle_tavg,       Qle_tavg)
    copy_VarAtts(f->Qh_tavg,        Qh_tavg)
    copy_VarAtts(f->Qg_tavg,        Qg_tavg)
    copy_VarAtts(f->Snowf_tavg,     Snowf_tavg)
    copy_VarAtts(f->Rainf_tavg,     Rainf_tavg)
    copy_VarAtts(f->Evap_tavg,      Evap_tavg)
    copy_VarAtts(f->PotEvap_tavg,   PotEvap_tavg)
    copy_VarAtts(f->ECanop_tavg,    ECanop_tavg)
    copy_VarAtts(f->Tveg_tavg,      Tveg_tavg)
    copy_VarAtts(f->ESoil_tavg,     ESoil_tavg)
    copy_VarAtts(f->AvgSurfT_inst,  AvgSurfT_inst)
    copy_VarAtts(f->Albedo_inst,    Albedo_inst)
    copy_VarAtts(f->SWE_inst,       SWE_inst)
    copy_VarAtts(f->SnowDepth_inst, SnowDepth_inst)
    copy_VarAtts(f->RootMoist_inst, RootMoist_inst)
    copy_VarAtts(f->CanopInt_inst,  CanopInt_inst)
    copy_VarAtts(f->Wind_f_inst,    Wind_f_inst)
    copy_VarAtts(f->Rainf_f_tavg,   Rainf_f_tavg)
    copy_VarAtts(f->Tair_f_inst,    Tair_f_inst)
    copy_VarAtts(f->Qair_f_inst,    Qair_f_inst)
    copy_VarAtts(f->Psurf_f_inst,   Psurf_f_inst)
    copy_VarAtts(f->Qs_acc,         Qs_acc)
    copy_VarAtts(f->Qsb_acc,        Qsb_acc)
    copy_VarAtts(f->Qsm_acc,        Qsm_acc)

    delete(Swnet_tavg@vmax)
    delete(SWdown_f_tavg@vmax)
    delete(LWdown_f_tavg@vmax)
    delete(Lwnet_tavg@vmax)
    delete(Qle_tavg@vmax)
    delete(Qh_tavg@vmax)
    delete(Qg_tavg@vmax)
    delete(Snowf_tavg@vmax)
    delete(Rainf_tavg@vmax)
    delete(Evap_tavg@vmax)
    delete(AvgSurfT_inst@vmax)
    delete(Albedo_inst@vmax)
    delete(SWE_inst@vmax)
    delete(SnowDepth_inst@vmax)
    delete(PotEvap_tavg@vmax)
    delete(ECanop_tavg@vmax)
    delete(Tveg_tavg@vmax)
    delete(ESoil_tavg@vmax)
    delete(RootMoist_inst@vmax)
    delete(CanopInt_inst@vmax)
    delete(Wind_f_inst@vmax)
    delete(Rainf_f_tavg@vmax)
    delete(Tair_f_inst@vmax)
    delete(Qair_f_inst@vmax)
    delete(Psurf_f_inst@vmax)
    delete(Qs_acc@vmax)
    delete(Qsb_acc@vmax)
    delete(Qsm_acc@vmax)

    delete(Swnet_tavg@vmin)
    delete(SWdown_f_tavg@vmin)
    delete(LWdown_f_tavg@vmin)
    delete(Lwnet_tavg@vmin)
    delete(Qle_tavg@vmin)
    delete(Qh_tavg@vmin)
    delete(Qg_tavg@vmin)
    delete(Snowf_tavg@vmin)
    delete(Rainf_tavg@vmin)
    delete(Evap_tavg@vmin)
    delete(AvgSurfT_inst@vmin)
    delete(Albedo_inst@vmin)
    delete(SWE_inst@vmin)
    delete(SnowDepth_inst@vmin)
    delete(PotEvap_tavg@vmin)
    delete(ECanop_tavg@vmin)
    delete(Tveg_tavg@vmin)
    delete(ESoil_tavg@vmin)
    delete(RootMoist_inst@vmin)
    delete(CanopInt_inst@vmin)
    delete(Wind_f_inst@vmin)
    delete(Rainf_f_tavg@vmin)
    delete(Tair_f_inst@vmin)
    delete(Qair_f_inst@vmin)
    delete(Psurf_f_inst@vmin)
    delete(Qs_acc@vmin)
    delete(Qsb_acc@vmin)
    delete(Qsm_acc@vmin)

    delete(Swnet_tavg@scale_factor)
    delete(SWdown_f_tavg@scale_factor)
    delete(LWdown_f_tavg@scale_factor)
    delete(Lwnet_tavg@scale_factor)
    delete(Qle_tavg@scale_factor)
    delete(Qh_tavg@scale_factor)
    delete(Qg_tavg@scale_factor)
    delete(Snowf_tavg@scale_factor)
    delete(Rainf_tavg@scale_factor)
    delete(Evap_tavg@scale_factor)
    delete(AvgSurfT_inst@scale_factor)
    delete(Albedo_inst@scale_factor)
    delete(SWE_inst@scale_factor)
    delete(SnowDepth_inst@scale_factor)
    delete(PotEvap_tavg@scale_factor)
    delete(ECanop_tavg@scale_factor)
    delete(Tveg_tavg@scale_factor)
    delete(ESoil_tavg@scale_factor)
    delete(RootMoist_inst@scale_factor)
    delete(CanopInt_inst@scale_factor)
    delete(Wind_f_inst@scale_factor)
    delete(Rainf_f_tavg@scale_factor)
    delete(Tair_f_inst@scale_factor)
    delete(Qair_f_inst@scale_factor)
    delete(Psurf_f_inst@scale_factor)
    delete(Qs_acc@scale_factor)
    delete(Qsb_acc@scale_factor)
    delete(Qsm_acc@scale_factor)

    delete(Swnet_tavg@add_offset)
    delete(SWdown_f_tavg@add_offset)
    delete(LWdown_f_tavg@add_offset)
    delete(Lwnet_tavg@add_offset)
    delete(Qle_tavg@add_offset)
    delete(Qh_tavg@add_offset)
    delete(Qg_tavg@add_offset)
    delete(Snowf_tavg@add_offset)
    delete(Rainf_tavg@add_offset)
    delete(Evap_tavg@add_offset)
    delete(AvgSurfT_inst@add_offset)
    delete(Albedo_inst@add_offset)
    delete(SWE_inst@add_offset)
    delete(SnowDepth_inst@add_offset)
    delete(PotEvap_tavg@add_offset)
    delete(ECanop_tavg@add_offset)
    delete(Tveg_tavg@add_offset)
    delete(ESoil_tavg@add_offset)
    delete(RootMoist_inst@add_offset)
    delete(CanopInt_inst@add_offset)
    delete(Wind_f_inst@add_offset)
    delete(Rainf_f_tavg@add_offset)
    delete(Tair_f_inst@add_offset)
    delete(Qair_f_inst@add_offset)
    delete(Psurf_f_inst@add_offset)
    delete(Qs_acc@add_offset)
    delete(Qsb_acc@add_offset)
    delete(Qsm_acc@add_offset)

    SoilMoisture                            = new( (/ ntime, 4, nlat, nlon  /)   ,  float)
    SoilMoisture!0                          = "time"
    SoilMoisture!1                          = "depth_of_soil_layer"
    SoilMoisture!2                          = "latitude"
    SoilMoisture!3                          = "longitude"
    SoilMoisture&time                       = time
    SoilMoisture&depth_of_soil_layer        = depth_of_soil_layer
    SoilMoisture&latitude                   = latitude
    SoilMoisture&longitude                  = longitude
    SoilMoisture@cell_methods               = "time: point"
    SoilMoisture@unit                       = "kg m-2"
    SoilMoisture@standard_name              = "soil_moisture_content" ;
    SoilMoisture@long_name                  = "Soil moisture" ;
    SoilMoisture@cell_methods               = "time: point" ;
    SoilMoisture@missing_value              = -9999. ;
    SoilMoisture@_FillValue                 = -9999.;

    SoilTemperature               = SoilMoisture
    SoilTemperature@unit          = "K"
    SoilTemperature@standard_name = "soil_temperature" ;
    SoilTemperature@long_name     = "Soil temperature"

    QVAL                            = new( (/ ntime  /)   ,  float)
    QVAL!0                          = "time"
    QVAL&time                       = time
    QVAL@description                = "Quality Code"

do t = 0, ntime-1

      print("===============================================")

      YYYYMMDDHH_asses = ut_calendar(assessed_time(t),-5)

      year_asses     = YYYYMMDDHH_asses(0,0)
      month_asses    = YYYYMMDDHH_asses(0,1)
      day_asses      = YYYYMMDDHH_asses(0,2)
      hour_asses     = YYYYMMDDHH_asses(0,3)

      file_name = "GLDAS_NOAH025_3H.A" + sprinti("%0.4i",  year_asses)   + \
                                         sprinti("%0.2i",  month_asses)  + \
                                         sprinti("%0.2i.", day_asses)    + \
                                         sprinti("%0.2i00", hour_asses)    + ".021.nc4"

      print(" "+file_name)


      if (isfilepresent(data_dir +  sprinti("%0.4i",  year_asses)  + "/" + file_name)) then

         QVAL(t) = 1
         f = addfile(data_dir +  sprinti("%0.4i",  year_asses)  + "/" + file_name, "r")

         Swnet_tavg(t,:,:)     = (/ f->Swnet_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Lwnet_tavg(t,:,:)     = (/ f->Lwnet_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SWdown_f_tavg(t,:,:)  = (/ f->SWdown_f_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         LWdown_f_tavg(t,:,:)  = (/ f->LWdown_f_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qle_tavg(t,:,:)       = (/ f->Qle_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qh_tavg(t,:,:)        = (/ f->Qh_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qg_tavg(t,:,:)        = (/ f->Qg_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Snowf_tavg(t,:,:)     = (/ f->Snowf_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Rainf_tavg(t,:,:)     = (/ f->Rainf_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Evap_tavg(t,:,:)      = (/ f->Evap_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         PotEvap_tavg(t,:,:)   = (/ f->PotEvap_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         ECanop_tavg(t,:,:)    = (/ f->ECanop_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Tveg_tavg(t,:,:)      = (/ f->Tveg_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         ESoil_tavg(t,:,:)     = (/ f->ESoil_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Wind_f_inst(t,:,:)    = (/ f->Wind_f_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Rainf_f_tavg(t,:,:)   = (/ f->Rainf_f_tavg(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Tair_f_inst(t,:,:)    = (/ f->Tair_f_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qair_f_inst(t,:,:)    = (/ f->Qair_f_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Psurf_f_inst(t,:,:)   = (/ f->Psurf_f_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         AvgSurfT_inst(t,:,:)  = (/ f->AvgSurfT_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Albedo_inst(t,:,:)    = (/ f->Albedo_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         RootMoist_inst(t,:,:) = (/ f->CanopInt_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         CanopInt_inst(t,:,:)  = (/ f->CanopInt_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SWE_inst(t,:,:)       = (/ f->SWE_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SnowDepth_inst(t,:,:) = (/ f->SnowDepth_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qs_acc(t,:,:)         = (/ f->Qs_acc(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qsb_acc(t,:,:)        = (/ f->Qsb_acc(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         Qsm_acc(t,:,:)        = (/ f->Qsm_acc(0,{start_lat:end_lat},{start_lon:end_lon}) /)

         SoilMoisture(t,0,:,:) = (/ f->SoilMoi0_10cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SoilMoisture(t,1,:,:) = (/ f->SoilMoi10_40cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SoilMoisture(t,2,:,:) = (/ f->SoilMoi40_100cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SoilMoisture(t,3,:,:) = (/ f->SoilMoi100_200cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)



         SoilTemperature(t,0,:,:) = (/ f->SoilTMP0_10cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SoilTemperature(t,1,:,:) = (/ f->SoilTMP10_40cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SoilTemperature(t,2,:,:) = (/ f->SoilTMP40_100cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)
         SoilTemperature(t,3,:,:) = (/ f->SoilTMP100_200cm_inst(0,{start_lat:end_lat},{start_lon:end_lon}) /)

         delete(f)

      else
         QVAL(t) = 0
       end if
       end do




f_template = addfile(demo_file_for_lat_lon,"r")


system("rm -frv "+ fileout_name)


f_out = addfile(fileout_name, "c")

f_out@local_SDSMT_modifications = "clipped to a smaller regions and aggregated by time"
f_out@tavg_definition           = "past 3-hour average"
f_out@acc_definition            = "past 3-hour accumulation"
f_out@inst_definition           = "instantaneous"
f_out@NOAH_definition           = "calculated in Noah v3.3 land surface model"
f_out@FORCING_definition        = "GLDAS meteorological forcings"
f_out@title                     = "GLDAS2.1 LIS land surface model output" ;
f_out@institution               = "NASA GSFC" ;
f_out@source                    = "Noah_v3.3" ;
f_out@references                = "Rodell_etal_BAMS_2004, Kumar_etal_EMS_2006, Peters-Lidard_etal_ISSE_2007" ;
f_out@conventions               = "CF-1.6" ;
f_out@comment_1                 = "website: http://ldas.gsfc.nasa.gov/gldas, http://lis.gsfc.nasa.gov/" ;
f_out@MAP_PROJECTION            = "EQUIDISTANT CYLINDRICAL" ;
f_out@SOUTH_WEST_CORNER_LAT     = min(latitude) ;
f_out@SOUTH_WEST_CORNER_LON     = min(longitude) ;
f_out@NORTH_EAST_CORNER_LAT     = max(latitude) ;
f_out@NORTH_EAST_CORNER_LON     = max(longitude) ;
f_out@DX                        = 0.25 ;
f_out@DY                        = 0.25 ;

f_out->time                       = time

delete(f_out)



system(" ncks -h --mk_rec_dmn time "+ fileout_name + " temp.nc")
system(" mv -v temp.nc " + fileout_name)
system(" ncdump -h  "+ fileout_name)

f_out = addfile(fileout_name, "rw")

f_out->depth_of_soil_layer       = depth_of_soil_layer
f_out->latitude                   = latitude
f_out->longitude                  = longitude



f_out->FORCING_Shortwave_Downward_Flux_tavg       = SWdown_f_tavg
f_out->FORCING_Longwave_Downward_Flux_tavg        = LWdown_f_tavg
f_out->FORCING_Air_Temperature_at_2m_inst         = Tair_f_inst
f_out->FORCING_Wind_Speed_at_10m_inst             = Wind_f_inst
f_out->FORCING_Total_Precipitation_Rate_inst      = Rainf_f_tavg
f_out->FORCING_Air_Specific_Humdity_at_2m_inst    = Qair_f_inst
f_out->FORCING_Air_Pressure_at_Surface_inst       = Psurf_f_inst
f_out->NOAH_Net_Shortwave_Radiation_tavg          = Swnet_tavg
f_out->NOAH_Net_Longwave_Radiation_tavg           = Lwnet_tavg
f_out->NOAH_Latent_Heat_Upward_Flux_tavg          = Qle_tavg
f_out->NOAH_Sensible_Heat_Upward_Flux_tavg        = Qh_tavg
f_out->NOAH_Ground_Downward_Flux_tavg             = Qg_tavg
f_out->NOAH_Snowfall_Rate_tavg                    = Snowf_tavg
f_out->NOAH_Rainfall_Rate_tavg                    = Rainf_tavg
f_out->NOAH_Evaporation_tavg                      = Evap_tavg
f_out->NOAH_Potential_Evaporation_tavg            = PotEvap_tavg
f_out->NOAH_Canopy_Evaporation_tavg               = ECanop_tavg
f_out->NOAH_Soil_Evaporation_tavg                 = ESoil_tavg
f_out->NOAH_Vegetation_Transpiration_tavg         = Tveg_tavg
f_out->NOAH_Radiative_Surface_Temperature_at_inst = AvgSurfT_inst
f_out->NOAH_Shortwave_Albedo_at_Surface_inst      = Albedo_inst
f_out->NOAH_Root_Zone_Soil_Moisture_inst          = RootMoist_inst
f_out->NOAH_Canopy_Surface_Water_inst             = CanopInt_inst
f_out->NOAH_Snow_Water_Equivalent_inst            = SWE_inst
f_out->NOAH_Snow_Depth_inst                       = SnowDepth_inst
f_out->NOAH_Soil_Moisture_inst                    = SoilMoisture
f_out->NOAH_Soil_Temperature_inst                 = SoilTemperature
f_out->NOAH_Surface_Runoff_acc                    = Qs_acc
f_out->NOAH_Baseflow_Runoff_acc                   = Qsb_acc
f_out->NOAH_Surface_Snow_Melt_acc                 = Qsm_acc
f_out->QVAL = QVAL

delete(f_out)
delete(f_template)

system("nccopy -k 3 -d 9  " + fileout_name + " " +fileout_name+"4")

if (isfilepresent(fileout_name+"4")) then

   system("rm -v " + fileout_name )
   print("Q$@&!&@#$^&(!&#&*@(!~&(*!)))")
   print("field is reporting missing")
end if

system("ncdump -h " + fileout_name+"4" )



end
