//*********************************************************************
//* ZKVSDEF - IDCAMS DEFINE for ZKVS on Hercules
//* Zane Hambly, 2026
//*
//* This is the Hercules equivalent of ZKVSCATD.mlc.
//* Real IDCAMS, real JCL, running on an emulated
//* mainframe on your laptop. What a time to be alive.
//*
//* Run this job before anything else touches the
//* VSAM file. IDCAMS DEFINE CLUSTER creates the
//* physical dataset. Without it you get an S013 ABEND
//* and a sense of existential dread.
//*
//* TODO: Fill in the actual DEFINE CLUSTER
//*       VOLUMES, CYLINDERS, RECORDSIZE, KEYS
//*       All the stuff that makes mainframe storage
//*       people feel important
//*********************************************************************
//ZKVSDEF  JOB (ZKVS),'ZANE HAMBLY',CLASS=A,MSGCLASS=X
//DEFCL    EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  /* DEFINE CLUSTER goes here */
  /* DEFINE CLUSTER -                */
  /*   NAME(ZKVS.DATA) -             */
  /*   INDEXED -                     */
  /*   KEYS(8 0) -                   */
  /*   RECORDSIZE(80 80) -           */
  /*   CYLINDERS(1 1)                */
/*
//
