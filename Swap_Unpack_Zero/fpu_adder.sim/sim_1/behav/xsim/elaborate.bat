@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Sat Nov 27 14:45:21 -0800 2021
REM SW Build 3118627 on Tue Feb  9 05:14:06 MST 2021
REM
REM Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab -wto 2417a9bb92124095898dec790c248f5a --incr --debug typical --relax --mt 2 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot Zero_Detect_testbench_behav xil_defaultlib.Zero_Detect_testbench xil_defaultlib.glbl -log elaborate.log"
call xelab  -wto 2417a9bb92124095898dec790c248f5a --incr --debug typical --relax --mt 2 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot Zero_Detect_testbench_behav xil_defaultlib.Zero_Detect_testbench xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0