# Toggleable Bool Column


This addon features switches to toggle boolean attributes values directly at the index,
avoiding the need of going the long way through the edit view to update a record.

<img src="./images/toggle-bool-column.gif" height="300" />

## Usage

Simply use `toggle_bool_column` at the index like this:

```ruby
index do
  toggle_bool_column :paid
end
```

The column label can be customized the same way as most column types:

`toggle_bool_column 'Payment OK', :paid`

### Important

The value update is done through the default update route, so you must check you have:
 - The `update` action enabled for the resource in its admin
 - The attribute listed among `permit_params`

 [Here](https://activeadmin.info/2-resource-customization.html) is described how both things go

 ### Conditionally show switch

 In some cases we want the switch to be present not in every row, but only for certain records.

 For this use the options `if` or `unless`.

 Records that don't match the condition will just show nothing in this column:

 `toggle_bool_column :paid, if: proc { |item| item.price.present? }`

 `toggle_bool_column :paid, unless: proc { |item| item.is_free? }`

 ### Success message

 Optionally a js alert dialog can be prompted to the user upon update success.

 This is disabled by default, but can be enabled by adding the option `success_message`

  `toggle_bool_column :paid, success_message: 'Item Updated Successfully!'`

  If the update fails for any reason, an "Error: Update Failed" alert will be prompted (this can't be disabled nor customized)

### Confirm message

Optionally a js confirm dialog can be prompted to the user to confirm the transition

This is disabled by default, but can be enabled by adding the option `confirm_toogle_true_message` for transition false to true

  `toggle_bool_column :paid, confirm_toogle_true_message: 'Do you want activate this resource?'`

  or `confirm_toogle_false_message` for transition true to false

  `toggle_bool_column :paid, confirm_toogle_false_message: 'Do you want de-activate this resource?'`