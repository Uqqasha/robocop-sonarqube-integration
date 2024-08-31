*** Settings ***
| Documentation    | This test suite covers all Sauce Demo Website Test Cases |
| Resource         | ../Resources/saucedemo_keywords.resource                 |
| Suite Setup      | Initialize                                               |

*** Test Cases ***
| Login Test                                            |
| | [Documentation] | Verifies the log in functionality |
| | [Tags]          | login                             |
| | Login           |                                   |

| Add To Cart Test                                           |
| | [Documentation] | Verifies the add to cart functionality |
| | [Tags]          | add-cart                               |
| | Add To Cart     |                                        |
| | [Teardown]      | Empty Cart                             |

| Remove From Cart Test                                            |
| | [Documentation]  | Verifies the remove from cart functionality |
| | [Tags]           | remove-item                                 |
| | Remove From Cart |                                             |

| Logout Test                                            |
| | [Documentation] | Verifies the log out functionality |
| | [Tags]          | logout                             |
| | Logout          |                                    |