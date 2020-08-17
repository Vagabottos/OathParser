# OathParser
A parser to reverse-engineer Oath TTS savefiles

## Installation

`npm i oath-parser`

## Usage

```
import { parseOathTTSSavefileString } from '@seiyria/oath-parser'

parseOathTTSSavefileString(yourSavefile);
```

You can see an example of this in `test/savefile.ts`.

## References

The Lua code is kept in `lua/`. It's copy/pasted out of the TTS mod for easier reference. It's not guaranteed to be up to date.

## Future

Serialize a savefile string by passing in a JSON object.

## Credits

- Cole & Leder Games: making this great game (& letting me make cool stuff)
- AgentElron: having such readable code!