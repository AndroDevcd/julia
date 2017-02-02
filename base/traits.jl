# This file is a part of Julia. License is MIT: http://julialang.org/license

## numeric/object traits
# trait for objects that have an ordering
abstract type TypeOrder end
struct type HasOrder <: TypeOrder end
struct type Unordered <: TypeOrder end

(::Type{TypeOrder})(instance) = TypeOrder(typeof(instance))
(::Type{TypeOrder}){T<:Real}(::Type{T}) = HasOrder()
(::Type{TypeOrder}){T}(::Type{T}) = Unordered()

# trait for objects that support arithmetic
abstract type TypeArithmetic end
struct type ArithmeticRounds <: TypeArithmetic end     # least significant bits can be lost
struct type ArithmeticOverflows <: TypeArithmetic end  #  most significant bits can be lost
struct type ArithmeticUnknown <: TypeArithmetic end

(::Type{TypeArithmetic})(instance) = TypeArithmetic(typeof(instance))
(::Type{TypeArithmetic}){T<:AbstractFloat}(::Type{T}) = ArithmeticRounds()
(::Type{TypeArithmetic}){T<:Integer}(::Type{T}) = ArithmeticOverflows()
(::Type{TypeArithmetic}){T}(::Type{T}) = ArithmeticUnknown()
