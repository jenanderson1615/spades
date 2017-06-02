//
//  Hand.swift
//  spades
//
//  Created by Jennifer Anderson on 12/15/16.
//  Copyright © 2016 Jennifer Anderson. All rights reserved.
//

import Foundation

class Hand: NSObject{
	var cards = [Card]()
	
	func bid() -> Int {
        if(cards.count == 0)
        {
            return 0
        }
        if areAllCardsSpades(){
            return 13
        }
        else{
            return 0
        }
	}
    
    /**
     Requires the cards array to have more than 1 card
     */
    func areAllCardsSpades() -> Bool {
        for card in cards {
            if card.suit != .Spade {
                return false
            }
        }
        return true
    }
	
	/**
	*/
	func spadeScore() -> Int {
		return self.spadeCount();
	}
	
	/**
	Calculates the number of spade leads we have.  Ace always counts as 1.  King counts as 1 if there's at least 1 spade, otherwise 0.  Queen counts as 1 if there's at least 2 other spades and so on
	*/
	func spadeLeads() -> Int {
		let spadeCount = self.spadeCount()
		var spadeLeads = 0
		for card in self.suitArray(ofSuitType:.Spade)
		{
			if card.rank == .Ace{
				spadeLeads += 1
			}
			if card.rank == .King && spadeCount >= 2{
				spadeLeads += 1
			}
			if card.rank == .Queen && spadeCount >= 3{
				spadeLeads += 1
			}
			if card.rank == .Jack && spadeCount >= 4{
				spadeLeads += 1
			}
			if card.rank == .Ten && spadeCount >= 5{
				spadeLeads += 1
			}
			if card.rank == .Nine && spadeCount >= 6{
				spadeLeads += 1
			}
			if card.rank == .Eight && spadeCount >= 7{
				spadeLeads += 1
			}
			if card.rank == .Seven && spadeCount >= 8{
				spadeLeads += 1
			}
			if card.rank == .Six && spadeCount >= 9{
				spadeLeads += 1
			}
			if card.rank == .Five && spadeCount >= 10{
				spadeLeads += 1
			}
			if card.rank == .Four && spadeCount >= 11{
				spadeLeads += 1
			}
			if card.rank == .Three && spadeCount >= 12{
				spadeLeads += 1
			}
			if card.rank == .Two && spadeCount >= 13{
				spadeLeads += 1
			}
		}
		return spadeLeads
	}
	
	/**
	*/
	func spadeCount() -> Int {
		var spadeCountInCards = 0
		for card in cards{
			if card.suit == .Spade{
				spadeCountInCards += 1
			}
		}
		return spadeCountInCards
	}
	
	/**
	 Returns all the cards in the hand of the suit type
	*/
	func suitArray(ofSuitType:Card.SuitType) -> [Card] {
		var cardArray = [Card]()
		for card in cards
		{
			if card.suit == ofSuitType
			{
				cardArray.append(card)
			}
		}
		return cardArray
	}
	
	/**
	*/
	func highestRank(inSuitType:Card.SuitType) -> Card.RankType {
		let cardsOfSuit = suitArray(ofSuitType: inSuitType)
		let twoCard = Card(rank: .Two, suit: inSuitType)
		var highestCardRank = twoCard.rankScore()
		for card in cardsOfSuit
		{
			if card.rankScore() > highestCardRank
			{
				highestCardRank = card.rankScore()
			}
		}
		return twoCard.rankForScore(score: highestCardRank)
	}
	
	/**
	For now, assumes the same order for hands
	*/
	func compareToHand(originalHand:[Card], comparisonHand:[Card]) -> Bool {
		var index = 0
		let comparisonHandCount = comparisonHand.count
		for card1 in originalHand {
			if(comparisonHandCount > index)
			{
				let comparisonHandCard = comparisonHand[index]
				if !card1.compareToCard(comparisonCard: comparisonHandCard)
				{
					return false
				}
				index += 1
			}
			else
			{
				return true
			}
		}
		return true
	}

}
