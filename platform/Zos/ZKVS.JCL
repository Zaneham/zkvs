//*********************************************************************
//* ZKVS - Run on real z/OS
//* Zane Hambly, 2026
//*
//* If you're running this on actual z/OS hardware,
//* congratulations: you have access to a mainframe
//* and you're using it to test a database written by
//* a bloke in New Zealand. Respect.
//*
//* This JCL is structurally identical to the Hercules
//* version. The difference is that the dataset names
//* point to real DASD instead of emulated volumes,
//* and the IDCAMS DEFINE in the setup job will have
//* real VOLSER and SMS class parameters.
//*
//* You'll need to adjust:
//*   - Dataset name prefixes (your site's naming convention)
//*   - VOLSER or SMS class for the VSAM cluster
//*   - STEPLIB to wherever you put the load module
//*   - SYSLIB to include your site's macro libraries
//*
//* If your shop has a standards document for JCL,
//* this probably violates it. Sorry about that.
//*
//* TODO: Everything. Get access to a mainframe first.
//*********************************************************************
//ZKVS     JOB (ZKVS),'ZANE HAMBLY',CLASS=A,MSGCLASS=X,
//         NOTIFY=&SYSUID
//*
//* STEP 1 - ASSEMBLE
//*
//ASM      EXEC PGM=ASMA90,PARM='DECK,NOOBJECT'
//SYSLIB   DD DSN=SYS1.MACLIB,DISP=SHR
//         DD DSN=&SYSUID..ZKVS.MACLIB,DISP=SHR
//SYSIN    DD DSN=&SYSUID..ZKVS.SOURCE(ZKVSCORE),DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSPUNCH DD DSN=&&OBJ,DISP=(,PASS),SPACE=(TRK,1)
//*
//* STEP 2 - LINK
//*
//LINK     EXEC PGM=IEWL
//SYSLIN   DD DSN=&&OBJ,DISP=(OLD,DELETE)
//SYSLMOD  DD DSN=&SYSUID..ZKVS.LOADLIB(ZKVSCORE),DISP=SHR
//SYSPRINT DD SYSOUT=*
//*
//* STEP 3 - RUN
//*
//RUN      EXEC PGM=ZKVSCORE
//STEPLIB  DD DSN=&SYSUID..ZKVS.LOADLIB,DISP=SHR
//VFILE    DD DSN=&SYSUID..ZKVS.DATA,DISP=SHR
//SYSPRINT DD SYSOUT=*
//
