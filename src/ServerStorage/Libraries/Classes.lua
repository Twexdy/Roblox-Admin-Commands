local module = {}

export type Result<T> = {didSucceed:boolean, resultValue:T}

function module.newResult<T>(didSucceed:boolean, resultValue:T): Result<T>
    local result:Result<T> = {didSucceed = didSucceed, resultValue = resultValue}
    return result
end

return module