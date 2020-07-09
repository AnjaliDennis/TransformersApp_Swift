//
//  TransformerConstants.swift
//  TransformersAppSwift
//
//  Created by Anjali Pragati Dennis on 06/07/20.
//  Copyright © 2020 Anjali Pragati Dennis. All rights reserved.
//

import Foundation

let CONSTANT_UNAVAILABLE_STRING = "Unavailable";
let CONSTANT_RATING_UNAVAILABLE_STRING = "Rating: Unavailable";
let CONSTANT_STATS_UNAVAILABLE_STRING = "Stats: Unavailable";
let CONSTANT_RANK_UNAVAILABLE_STRING = "Rank: Unavailable";
let CONSTANT_BATTLE_MISSED_STRING = "Battle Missed";
let CONSTANT_COMMENCE_BATTLE_STRING = "Commence Battle";
let CONSTANT_RATING_STRING = "Rating: ";
let CONSTANT_STATS_STRING = "Stats: ";
let CONSTANT_RANK_STRING = "Rank: ";
let CONSTANT_STRENGTH_STRING = "Strength: ";
let CONSTANT_INTELLIGENCE_STRING = "Intelligence: ";
let CONSTANT_SPEED_STRING = "Speed: ";
let CONSTANT_ENDURANCE_STRING = "Endurance: ";
let CONSTANT_COURAGE_STRING = "Courage: ";
let CONSTANT_FIREPOWER_STRING = "Firepower: ";
let CONSTANT_SKILL_STRING = "Skill: ";
let CONSTANT_SURVIVOR_STRING = "Survivor";
let CONSTANT_TRANSFORMERS_KEY_STRING = "transformers";
let CONSTANT_RANK_KEY_STRING = "rank";
let CONSTANT_ID_KEY_STRING = "id";
let CONSTANT_NAME_KEY_STRING = "name";
let CONSTANT_STRENGTH_KEY_STRING = "strength";
let CONSTANT_INTELLIGENCE_KEY_STRING = "intelligence";
let CONSTANT_SPEED_KEY_STRING = "speed";
let CONSTANT_ENDURANCE_KEY_STRING = "endurance";
let CONSTANT_COURAGE_KEY_STRING = "courage";
let CONSTANT_FIREPOWER_KEY_STRING = "firepower";
let CONSTANT_SKILL_KEY_STRING = "skill";
let CONSTANT_TEAM_KEY_STRING = "team";
let CONSTANT_TEAM_ICON_KEY_STRING = "team_icon";
let CONSTANT_TEAM_AUTOBOT_STRING = "A";
let CONSTANT_TEAM_DECEPTICON_STRING = "D";
let CONSTANT_AUTOBOT_ANNIHILATOR_NAME_STRING = "optimus prime";
let CONSTANT_DECEPTICON_ANNIHILATOR_NAME_STRING = "predaking";
let CONSTANT_WINNER_STRING = "Winner";
let CONSTANT_LOSER_STRING = "Loser";
let CONSTANT_DESTROYED_STRING = "Destroyed";
let CONSTANT_GAMEOVER_STRING = "Game over by Annihilation";
let CONSTANT_BATTLE_AUTOBOTS_STRING = "Battle is won by AUTOBOTS";
let CONSTANT_BATTLE_DECEPTICONS_STRING = "Battle is won by DECEPTICONS";
let CONSTANT_BATTLE_TIE_STRING = "Battle is a TIE";
let CONSTANT_BATTLE_INSUFFICIENT_STRING = "Battle Indeterminate,Insufficient Transformers";
let CONSTANT_ALERT_SUCCESS_TITLE_STRING = "Success";
let CONSTANT_ALERT_FAILURE_TITLE_STRING = "Failure";
let CONSTANT_ALERT_CREATE_SUCCESS_MESSAGE_STRING = "Transformer has been created successfully";
let CONSTANT_ALERT_CREATE_FAILURE_MESSAGE_STRING = "Failed to create Transformer. Please Try Again";
let CONSTANT_ALERT_BUTTON_OK = "OK";
let CONSTANT_ALERT_DELETE_SUCCESS_MESSAGE_STRING = "Transformer has been deleted successfully";
let CONSTANT_ALERT_DELETE_FAILURE_MESSAGE_STRING = "Failed to delete Transformer. Please Try Again";
let CONSTANT_ALERT_UPDATE_SUCCESS_MESSAGE_STRING = "Transformer has been updated successfully";
let CONSTANT_ALERT_UPDATE_FAILURE_MESSAGE_STRING = "Failed to update Transformer. Please Try Again";
let CONSTANT_SAVE_BUTTON = "Save";
let CONSTANT_EDIT_BUTTON_OK = "Edit";
let CONSTANT_REFRESH = "refreshRequired";

let CONSTANT_URL_TOKEN = "https://transformers-api.firebaseapp.com/allspark";
let CONSTANT_URL = "https://transformers-api.firebaseapp.com/transformers";
let CONSTANT_URL_AUTOBOT_TEAMICON = "https://tfwiki.net/mediawiki/images2/archive/f/fe/20110410191732%21Symbol_autobot_reg.png";
let CONSTANT_URL_DECEPTICON_TEAMICON = "https://tfwiki.net/mediawiki/images2/archive/8/8d/20110410191659%21Symbol_decept_reg.png";


enum ResultType
{
    case Success(result: Any)
    case Error(error: Error)
}
