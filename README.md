# What's that
This is my first long-term project. The app is available [here](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://apps.apple.com/fr/app/sneakerstock/id1663638520&ved=2ahUKEwiR2MaHivKGAxXJQ6QEHUTBCWUQFnoECBMQAQ&usg=AOvVaw1QLOKswlyB9zdBQjSyKlr2), but it’s only compatible with iPhones.
The Android version is in development.


## DataModel

```python
- SHOES
  - id: UUID
  - name: STRING
  - size: D
  - deletingRecentlyDate: DATE
  - brand: STRING
  - imageShoes: BINARY DATA
  - isInDeletingRecentlyState: BOOLEAN
  - jour: DATE
  - price: DOUBLE
  - priceStr: STRING
  - ressellPrice: STRING
  - selldate: DATE
  - sellValue: DOUBLE
  - sellWebsite: STRING
  - stockxStyle: STRING
```
