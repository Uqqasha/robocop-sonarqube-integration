*** Settings ***
| Documentation    | This is keywords resource file for Sauce Demo testcases. |
| Library          | OperatingSystem                                          |
| Library          | Browser | run_on_failure= Take Screenshot \ EMBED        |
| Resource         | ../Resources/variables.resource                          |

*** Keywords ***
| Initialize                                                          |
| | [Documentation] | Initialize test suite                           |
| | New Browser     | ${BROWSER}   | ${HEADLESS} | channel=${CHANNEL} |
| | New Context     |                                                 |
| | New Page        | ${URL}                                          |

| Login                                                                          |
| | [Documentation] | Login functionality                                        |
| | ${heading}=     | Get Element States | //div[contains(@class, 'login_logo')] |
| | IF  | 'visible' not in $heading                                              |
| |     | Initialize                                                             |
| | END |                                                                        |
| | Environment Variable Should Be Set                  | PASSWORD               |
| | Type Text       | //input[@name="user-name"]        | ${username}            |
| | Type Secret     | //input[@name="password"]         | $password              |
| | Click           | //input[@type="submit"]                                    |
| | Get Text        | //span[contains(@class, 'title')] | equal | Products       |

| Add To Cart                                                                |
| | [Documentation] | Add to cart functionality                              |
| | ${heading}=     | Get Element States | //span[contains(@class, 'title')] |
| | IF  | 'visible' not in $heading                                          |
| |     | Login                                                              |
| | END |                                                                    |
| | ${count}= | Get Element Count | //a[@class="shopping_cart_link"]/span    |
| | IF  | $count > 1                                                         |
| |     | Empty Cart                                                         |
| | END |                                                                    |
| | Click | //button[@id="add-to-cart-sauce-labs-backpack"]                  |
| | ${count}= | Get Element Count | //a[@class="shopping_cart_link"]/span    |
| | IF  | $count >= 1                                                        |
| |     | Pass Execution          | Item added to cart                       |
| | END |                                                                    |

| Empty Cart                                                        |
| | [Documentation] | Empties the cart                              |
| | Click           | //a[@class="shopping_cart_link"]              |
| | ${item_count}=  | Get Element Count | //div[@class="cart_item"] |
| | FOR  | ${i}  | IN RANGE | 1 | ${item_count+1}                   |
| |      | Click | //button[contains(text(),"Remove")][1]           |
| | END  |                                                          |
| | Click           | //button[@id="continue-shopping"]             |

| Remove From Cart                                                           |
| | [Documentation] | Remove from cart functionality                         |
| | ${heading}=     | Get Element States | //span[contains(@class, 'title')] |
| | IF  | 'visible' not in $heading                                          |
| |     | Login                                                              |
| | END |                                                                    |
| | Click | //button[contains(text(), "Remove")]                             |

| Logout                                                                         |
| | [Documentation] | Logout functionality                                       |
| | ${heading}=     | Get Element States | //div[contains(@class, 'login_logo')] |
| | IF  | 'visible' in $heading                                                  |
| |     | Login                                                                  |
| | END |                                                                        |
| | Click    | //button[contains(text(), "Open Menu")]                           |
| | Click    | //a[contains(text(), "Logout")]                                   |
| | Get Text | //div[contains(@class, 'login_logo')] | equal | Swag Labs         |