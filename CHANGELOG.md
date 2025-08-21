# CHANGELOG

## 0.0.9

- Refactored `CircularIndicator` to use the new `CircularValue` class for value representation.
- Replaced previous parameters in `CircularIndicator.single(int currentValue, int maxValue)` with `CircularIndicator.single(CircularValue value)`.
- Applied the same change to `CircularIndicator.double`, now accepting `CircularValue` instances.
- Introduced `CircularIndicator.percent`, which displays a single indicator with the percentage value shown at the center and between the labels.

## 0.0.8

Minor fixes

## 0.0.7

Added CTextStyle class

## 0.0.6

Minor fixes

## 0.0.5

- Button radius bug fixed
- AppRadius exposed
- CText size bug fixed
- Added underline getter to CText class and withColor, withSize and withWeight setter

## 0.0.4

Some bugs Fixed

## 0.0.3

bugs fixed

## 0.0.2

minor adjustments

## 0.0.1

Initial version, created by Lorenzo Busi
