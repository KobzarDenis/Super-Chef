import { BelongsTo, BelongsToMany, Column, ForeignKey, Model, Table } from "sequelize-typescript";
import { FoodGroup } from "./FoodGroup.model";
import { FoodIngredient } from "./FoodIngredient.model";
import { Ingredient } from "./Ingredient.model";
import { OrderFood } from "./OrderFood.model";
import { ServiceOrder } from "./ServiceOrder.model";

@Table({
  timestamps: false,
  freezeTableName: true,
  tableName: "foods",
  schema: "service"
})
export class Food extends Model<Food> {
  @ForeignKey(() => FoodGroup)
  @Column
  public groupId: number;

  @Column
  public name: string;

  @Column
  public description: string;

  @Column
  public price: number;

  @BelongsTo(() => FoodGroup)
  public foodGroup: FoodGroup;

  @BelongsToMany(() => Ingredient, () => FoodIngredient)
  public ingredients: Ingredient[];

  @BelongsToMany(() => ServiceOrder, () => OrderFood)
  public orders: ServiceOrder[];
}
