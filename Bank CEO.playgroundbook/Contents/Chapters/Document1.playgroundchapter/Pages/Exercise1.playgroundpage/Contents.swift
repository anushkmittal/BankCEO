//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2017 Anushk Mittal. All Rights Reserved.
//
//#-end-hidden-code
/*:
 # Blink: A Cell Simulator
 Blink is a simulation that explores how a living cell reproduces or dies given a certain set of rules. Your goal is to understand the algorithms that run the simulation so that you can create your own version, with your own rules.
 
 This playground is running a modified version of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), which presents cells reproducing and dying based upon the status of the 8 neighboring cells. You will see this simulation in the **live view** when you run the code.
 
 The rules for this simulation are:
 * Any living cell with fewer than two living neighbors dies.
 * Any living cell with two or three living neighbors lives on.
 * Any living cell with more than three living neighbors dies.
 * Any dead cell with exactly three living neighbors becomes a living cell.
 
 The cell simulator uses a loop to evaluate all cells on the grid. For each iteration of the loop, the rules are applied and a new generation of cells is created. Experiment with stepping through the simulation to watch this happen. On the next page, you'll explore modifying this algorithm.
 */
//#-editable-code

import PlaygroundSupport
import UIKit

let master = DashboardViewController()



let nav = UINavigationController(rootViewController: master)

PlaygroundPage.current.liveView = nav

print(master.bank.excessReserves)
print(master.bank.bankReserves)


// risk managed through code for LoansViewController


//#-end-editable-code
