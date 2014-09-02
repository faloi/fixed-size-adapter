angular.module "fixedSizeAdapterApp"
.filter "checkmark", ->
  (input) -> if input then "✓" else "✘"