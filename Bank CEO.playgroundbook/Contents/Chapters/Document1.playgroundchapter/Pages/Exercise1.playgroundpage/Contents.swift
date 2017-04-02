//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2017 Anushk Mittal. All Rights Reserved.
//
//#-end-hidden-code
/*:
 # BankCEO: A Bank Stimulator
 
 BankCEO is a simulation that explores how a real world bank stimulates the economy and produces cash out of thin air. Your goal is to understand the algorithms that run the stimulation so that you can modify the external factors and Fed regulations besides bank policies and create your own version of bank, with in your own hypothetical world.
 
 The playground is running a modified version of how a real world bank works with related factors of uncertainty in the market. You’re the CEO of a newly launched bank. Starting with initial deposits of $10 million, your target is to increase the bank assets through a series of manipulations in interest rates and investment / loan strategies that deem suitable for each quarter.
 
 
 The basic rules of a banking system are:
 * An increase in interest rate given on deposits would increase the supply of deposits
 * An decrease in interest rate charged on loans would increase the demand of loanable funds
 * Investments are generally more profitable and less risky when compared to tradeoffs against loans
 * Government bonds are less risky to invest but also produce low income
 * Corporate bonds are more riskier than government bonds and so produce a higher income
 * Investing in Stock Markets is very risky. The key here is to diversify.
 * The tradeoff against diversification is probability of earning a bumper income occasionally as compared to higher risk of loosing or most invest money.
 * Fed can manipulate bank income by changing reserve requirements.
 
 On the next page, you'll explore modifying this algorithm to change fed requirements and manipulate external events.
 
 */
//#-hidden-code

import PlaygroundSupport
import UIKit

let master = DashboardViewController()
let nav = UINavigationController(rootViewController: master)

PlaygroundPage.current.liveView = nav

//#-end-hidden-code
