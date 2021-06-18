
import { Citizenship, PlayerColor, Suit } from './enums';

export interface Card {
  name: string;
}

export interface Site {
  name: string;
  ruined: boolean;
  cards: Card[];
}

export interface OathGame {
  version: {
    major: string
    minor: string
    patch: string
  }

  gameCount: number;
  chronicleName: string;

  playerCitizenship: Record<PlayerColor, Citizenship>;
  oath: string;
  suitOrder: Suit[];
  sites: Site[];
  world: Card[];
  dispossessed: Card[];
  relics: Card[];

  prevPlayerCitizenship: Record<PlayerColor, Citizenship>;
  winner: PlayerColor;
}
