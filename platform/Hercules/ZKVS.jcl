//*********************************************************************
//* ZKVS - Run the ZKVS database program on Hercules
//* Zane Hambly, 2026
//*
//* Assembles, links, and runs the ZKVS core.
//* Assumes you've already run ZKVSDEF.jcl to create
//* the VSAM cluster. If you haven't, this will fail
//* and you'll know exactly why because you read this
//* comment. Right?
//*
//* The STEPLIB points to wherever the assembled load
//* module ends up. The VFILE DD maps the logical name
//* to the physical VSAM cluster.
//*
//* TODO: Fill in the real dataset names
//*       Sort out the STEPLIB
//*       Actually have something to assemble
//*********************************************************************
//ZKVS     JOB (ZKVS),'ZANE HAMBLY',CLASS=A,MSGCLASS=X
//*
//* STEP 1 - ASSEMBLE
//*
//ASM      EXEC PGM=ASMA90,PARM='DECK,NOOBJECT'
//SYSLIB   DD DSN=SYS1.MACLIB,DISP=SHR
//         DD DSN=ZKVS.MACLIB,DISP=SHR
//SYSIN    DD DSN=ZKVS.SOURCE(ZKVSCORE),DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSPUNCH DD DSN=&&OBJ,DISP=(,PASS),SPACE=(TRK,1)
//*
//* STEP 2 - LINK
//*
//LINK     EXEC PGM=IEWL
//SYSLIN   DD DSN=&&OBJ,DISP=(OLD,DELETE)
//SYSLMOD  DD DSN=ZKVS.LOADLIB(ZKVSCORE),DISP=SHR
//SYSPRINT DD SYSOUT=*
//*
//* STEP 3 - RUN
//*
//RUN      EXEC PGM=ZKVSCORE
//STEPLIB  DD DSN=ZKVS.LOADLIB,DISP=SHR
//VFILE    DD DSN=ZKVS.DATA,DISP=SHR
//SYSPRINT DD SYSOUT=*
//
