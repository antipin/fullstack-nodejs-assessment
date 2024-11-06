import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, MaxLength, IsNumber, Min, Max } from 'class-validator';

export class CocktailDto {
  
  @IsNotEmpty()
  @ApiProperty({
    type: Number,
    description: "Cocktail's ID",
    example: 42,
  })
  id: number;

  @IsNotEmpty()
  @MaxLength(100)
  @ApiProperty({
    type: String,
    description: "Cocktail's title",
    example: "Nojito",
  })
  title: string;

  @IsNotEmpty()
  @MaxLength(1024)
  @ApiProperty({
    type: String,
    description: "Cocktail's description",
    example: "A non-alcoholic version of the classic Mojito.",
  })
  description: string;

  @IsNotEmpty()
  @IsNumber()
  @Min(0)
  @Max(999)
  @ApiProperty({
    type: Number,
    description: "Cocktail's price",
    example: 2.99,
    minimum: 0,
    maximum: 999,
  })
  price: number;
}