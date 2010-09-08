ActiveRecord Avanzado - Part 1
==============================
:Author: Marcos Vanetta
:Year: 2010
:mail: marcos.vanetta@aycron.com
**Aycron**

Agenda
-------
* Validations and how to skip them
* conditional search
* Changed?
* Order
* Named_scope
* Default_scope
* Include & Join (differences)

Validatios
-------------------------------
Validations are used to ensure that only valid data is saved into your database.[1]
* Use[2]
    validate_XXX_of :field, \*attr_names
* Attr: message, allow_nil, allow_blank, with, on, if unless

.. code-block::ruby
    class User < ActiveRecord::Base
      validates_presence_of :first_name
      validates_format_of :email,
                          :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                          :on => :create,
                          :message => "email must be valid"
      validate_uniqueness_of :email
    end
:Demo: 1

References
----------
1. http://guides.rubyonrails.org/active_record_validations_callbacks.html
2. http://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_format_of

