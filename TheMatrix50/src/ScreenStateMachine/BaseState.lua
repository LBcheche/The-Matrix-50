--[[
    THE MATRIX 50 - 2020

    Author: Leonardo G. C. Bcheche
    lbcheche@gmail.com

    Original Credit: Harvard - CS50, GD50
    
    Original Author: Colton Ogden
    cogden@cs50.harvard.edu

    [EN] -- BaseState Class --

    Used as the base class for all of our states, so we don't have to
    define empty methods in each of them. StateMachine requires each
    State have a set of four "interface" methods that it can reliably call,
    so by inheriting from this base state, our State classes will all have
    at least empty versions of these methods even if we don't define them
    ourselves in the actual classes.

    == Works like an Abstract Class ==

    [BR PT] -- BaseState Class --

    Usado como classe base para todos os nossos estados, náo haverá necessidade
    de definir métodos vazios em cada um deles. 
    O StateMachine requer que cada State Class tenha um conjunto de quatro métodos 
    de "interface" que ele pode chamar de forma confiável,
    Assim, ao herdar esta classe base, todas as nossas State Class terão
    pelo menos versões vazias destes métodos, mesmo que não as definamos
    nas respectivas classes.
    
    == Functiona como Classe Abstrata ==

]]

BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end