
import { CardNameIndexes, Citizenship, Oath, OathGame, PlayerColor, SiteNameIndexes } from './interfaces';

const CHRONICLE_NAME_MIN_LENGTH = 1;
const CHRONICLE_NAME_MAX_LENGTH = 255;

enum SavefileDataType {
  VersionMajor,
  VersionMinor,
  VersionPatch,
  GameCount,
  ChronicleNameLength,
  PlayerStatus,
  ExileCitizenStatus,
  Oath,
  SuitDiscord,
  SuitHearth,
  SuitNomad,
  SuitArcane,
  SuitOrder,
  SuitBeast,
  Site1,
  Site2,
  Site3,
  Site4,
  Site5,
  Site6,
  Site7,
  Site8,
  WorldDeckSize,
  DispossessedDeckSize,
  RelicDeckSize
}

const Indices: Record<SavefileDataType, (offset: number) => ({ start: number, end: number })> = {
  [SavefileDataType.VersionMajor]:            (offset: number) => ({ start: 0,            end: 2 }),
  [SavefileDataType.VersionMinor]:            (offset: number) => ({ start: 2,            end: 4 }),
  [SavefileDataType.VersionPatch]:            (offset: number) => ({ start: 4,            end: 6 }),
  [SavefileDataType.GameCount]:               (offset: number) => ({ start: 6,            end: 10 }),
  [SavefileDataType.ChronicleNameLength]:     (offset: number) => ({ start: 10,           end: 12 }),

  // offset dynamically set to chronicle name length between these places

  [SavefileDataType.PlayerStatus]:            (offset: number) => ({ start: offset + 0,   end: offset + 2 }),

  [SavefileDataType.ExileCitizenStatus]:      (offset: number) => ({ start: offset + 2,   end: offset + 4 }),

  [SavefileDataType.Oath]:                    (offset: number) => ({ start: offset + 4,   end: offset + 6 }),

  [SavefileDataType.SuitDiscord]:             (offset: number) => ({ start: offset + 6,   end: offset + 7 }),
  [SavefileDataType.SuitHearth]:              (offset: number) => ({ start: offset + 7,   end: offset + 8 }),
  [SavefileDataType.SuitNomad]:               (offset: number) => ({ start: offset + 8,   end: offset + 9 }),
  [SavefileDataType.SuitArcane]:              (offset: number) => ({ start: offset + 9,   end: offset + 10 }),
  [SavefileDataType.SuitOrder]:               (offset: number) => ({ start: offset + 10,  end: offset + 11 }),
  [SavefileDataType.SuitBeast]:               (offset: number) => ({ start: offset + 11,  end: offset + 12 }),

  [SavefileDataType.Site1]:                   (offset: number) => ({ start: offset + 12,  end: offset + 14 }),
  [SavefileDataType.Site2]:                   (offset: number) => ({ start: offset + 20,  end: offset + 22 }),
  [SavefileDataType.Site3]:                   (offset: number) => ({ start: offset + 28,  end: offset + 30 }),
  [SavefileDataType.Site4]:                   (offset: number) => ({ start: offset + 36,  end: offset + 38 }),
  [SavefileDataType.Site5]:                   (offset: number) => ({ start: offset + 44,  end: offset + 46 }),
  [SavefileDataType.Site6]:                   (offset: number) => ({ start: offset + 52,  end: offset + 54 }),
  [SavefileDataType.Site7]:                   (offset: number) => ({ start: offset + 60,  end: offset + 62 }),
  [SavefileDataType.Site8]:                   (offset: number) => ({ start: offset + 68,  end: offset + 70 }),
  [SavefileDataType.WorldDeckSize]:           (offset: number) => ({ start: offset + 76,  end: offset + 78 }),

  // offset dynamically set to world deck size between these places

  [SavefileDataType.DispossessedDeckSize]:    (offset: number) => ({ start: offset + 0,   end: offset + 2 }),

  // offset dynamically set to dispossessed deck size between these places

  [SavefileDataType.RelicDeckSize]:           (offset: number) => ({ start: offset + 0,   end: offset + 2 })
};

function parseCitizenshipByte(byte: number): Record<PlayerColor, Citizenship> {  
  const citizenships: Record<PlayerColor, Citizenship> = {
    [PlayerColor.Brown]:  Citizenship.Exile,
    [PlayerColor.Yellow]: Citizenship.Exile,
    [PlayerColor.White]:  Citizenship.Exile,
    [PlayerColor.Blue]:   Citizenship.Exile,
    [PlayerColor.Red]:    Citizenship.Exile
  };

  if(byte & 0x10) citizenships[PlayerColor.Brown] = Citizenship.Citizen;
  if(byte & 0x08) citizenships[PlayerColor.Yellow] = Citizenship.Citizen;
  if(byte & 0x04) citizenships[PlayerColor.White] = Citizenship.Citizen;
  if(byte & 0x02) citizenships[PlayerColor.Blue] = Citizenship.Citizen;
  if(byte & 0x01) citizenships[PlayerColor.Red] = Citizenship.Citizen;

  return citizenships;
}

export function parseOathTTSSavefileString(saveDataString: string): OathGame {

  let parseOffsetForName = 0;

  function getHexFromStringAsNumber(startIndex: number, endIndex: number): number {
    const parsedString = saveDataString.substring(startIndex, endIndex);
    if(!parsedString) throw new Error(`Could not parse savefile ${startIndex}...${endIndex} - returned blank.`);

    const parsedNumber = parseInt(parsedString, 16);
    if(isNaN(parsedNumber)) throw new Error(`Savefile ${startIndex}...${endIndex} is NaN - something is wrong.`);

    return parsedNumber;
  }

  function getStartEndByIndex(type: SavefileDataType): { start: number, end: number } {
    return Indices[type](parseOffsetForName);
  }

  function getHexByIndex(type: SavefileDataType): number {
    const { start, end } = getStartEndByIndex(type);
    return getHexFromStringAsNumber(start, end);
  }

  function updateOffset(newOffset: number): void {
    parseOffsetForName = newOffset;
  }

  const game: Partial<OathGame> = {};

  // the first 6 characters represent the version of the savefile
  const oathMajor = getHexByIndex(SavefileDataType.VersionMajor);
  const oathMinor = getHexByIndex(SavefileDataType.VersionMinor);
  const oathPatch = getHexByIndex(SavefileDataType.VersionPatch);

  game.version = { 
    major: oathMajor.toString(), 
    minor: oathMinor.toString(), 
    patch: oathPatch.toString() 
  };
    
  if(oathMajor < 3 && oathMinor < 1) {
    throw new Error('Oath savefile version 3.1.0 is the minimum required.');
  }

  // the first X bytes are always going to be related to 1.6.0
  const parseData_1_6_0 = () => {

    // parse game count
    game.gameCount = getHexByIndex(SavefileDataType.GameCount);

    // get the length of the name
    const nameLength = getHexByIndex(SavefileDataType.ChronicleNameLength);
    const { end: nameEnd } = Indices[SavefileDataType.ChronicleNameLength](0);

    // get the name
    game.chronicleName = saveDataString.substring(nameEnd, nameEnd + nameLength);

    // set the new offset to the game name, since everything after name needs to know the length of it
    updateOffset(nameEnd + nameLength);

    // validate the name
    if(game.chronicleName.length < CHRONICLE_NAME_MIN_LENGTH
    || game.chronicleName.length > CHRONICLE_NAME_MAX_LENGTH) {
      throw new Error(`Chronicle name must be between ${CHRONICLE_NAME_MIN_LENGTH} and ${CHRONICLE_NAME_MAX_LENGTH} (${game.chronicleName} is ${game.chronicleName.length})`);
    } 

    // we throw the player status out, but it's here so it's not forgotten about
    getHexByIndex(SavefileDataType.PlayerStatus);

    // get citizenship for each player
    const exileCitizenStatusByte = getHexByIndex(SavefileDataType.ExileCitizenStatus);
    game.playerCitizenship = parseCitizenshipByte(exileCitizenStatusByte);

    // parse the oath from the game
    game.oath = Oath[getHexByIndex(SavefileDataType.Oath)];
    if(!game.oath) throw new Error('Invalid Oath value was found while parsing the savefile.');

    // make sure all suit codes are found
    game.suitOrder = [
      SavefileDataType.SuitDiscord,
      SavefileDataType.SuitHearth,
      SavefileDataType.SuitNomad,
      SavefileDataType.SuitArcane,
      SavefileDataType.SuitOrder,
      SavefileDataType.SuitBeast
    ]
    .map(suitSlot => {
      return { suit: SavefileDataType[suitSlot].split('Suit')[1], order: getHexByIndex(suitSlot) }
    })
    .reduce((prev, cur) => {
      prev[cur.order] = cur.suit;
      return prev;
    }, []);

    // load sites
    game.sites = [
      SavefileDataType.Site1,
      SavefileDataType.Site2,
      SavefileDataType.Site3,
      SavefileDataType.Site4,
      SavefileDataType.Site5,
      SavefileDataType.Site6,
      SavefileDataType.Site7,
      SavefileDataType.Site8
    ]
    .map(siteSlot => {
      const { start: siteStart, end: siteEnd } = getStartEndByIndex(siteSlot);
      const siteData = getHexFromStringAsNumber(siteStart, siteEnd);
      
      const cards = Array(3).fill(null).map((n, i) => {
        const cardData = getHexFromStringAsNumber(siteEnd + (2 * i), siteEnd + (2 * (i + 1)));
        return { name: CardNameIndexes[cardData] };
      });

      return { 
        name: SiteNameIndexes[siteData], 
        ruined: siteData >= 24,
        cards
      };
    });

    // load world deck count
    const { start: worldStart, end: worldEnd } = getStartEndByIndex(SavefileDataType.WorldDeckSize);
    const numWorldCards = getHexFromStringAsNumber(worldStart, worldEnd);

    // load world deck
    game.world = Array(numWorldCards).fill(null).map((n, i) => {
      const cardData = getHexFromStringAsNumber(worldEnd + (2 * i), worldEnd + (2 * (i + 1)));
      return { name: CardNameIndexes[cardData] };
    });
    
    updateOffset(worldEnd + (2 * numWorldCards));

    // load dispossessed cards
    const { start: dispStart, end: dispEnd } = getStartEndByIndex(SavefileDataType.DispossessedDeckSize);
    const numDispossessed = getHexFromStringAsNumber(dispStart, dispEnd);

    game.dispossessed = Array(numDispossessed).fill(null).map((n, i) => {
      const cardData = getHexFromStringAsNumber(dispEnd + (2 * i), dispEnd + (2 * (i + 1)));
      return { name: CardNameIndexes[cardData] };
    });
    
    updateOffset(dispEnd + (2 * numDispossessed));
  };
  
  // 3.1.0 adds relics, so they require additional parsing
  const parseData_3_1_0 = () => {

    // load relic cards
    const { start: relicStart, end: relicEnd } = getStartEndByIndex(SavefileDataType.RelicDeckSize);
    const numRelics = getHexFromStringAsNumber(relicStart, relicEnd);

    game.relics = Array(numRelics).fill(null).map((n, i) => {
      const cardData = getHexFromStringAsNumber(relicEnd + (2 * i), relicEnd + (2 * (i + 1)));
      return { name: CardNameIndexes[cardData] };
    });
    
    updateOffset(relicEnd + (2 * numRelics));
  };

  parseData_1_6_0();
  parseData_3_1_0();

  return game as OathGame;
};