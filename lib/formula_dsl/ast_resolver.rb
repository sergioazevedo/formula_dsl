#encoding: utf-8

class AstResolver

  def apply( ast )
    expression = parse(ast)

    expression
  end

private

  def parse( hash )
    if hash.keys.size == 1
      parse_single_key_hash( hash )
    else
      puts "como faz o parse de um hash com mais de 1 chave???"
    end
  end

  def parse_single_key_hash( hash )
    key = hash.keys.first
    if is_operator? key
      parse_operation key, hash[key]
    elsif is_function? key
      parse_function hash[key]
    else
      puts "como faz o parse de um hash com chave = #{key}???"
    end
  end

  def is_operator?( key )
    [:+, :-, :*, :/].include?(key)
  end

  def is_function?(key)
    :function == key
  end

  def parse_operation(operator, values={left: '', right: ''})
    left_side  = extract_operation_side(values[:left])
    right_side = extract_operation_side(values[:right])

    BinaryOperation.new(operator, left_side, right_side)
  end

  def parse_function( hash = {name:'', args:''} )
    Function.new(hash[:name].to_str, hash[:args].to_str)
  end

  def extract_operation_side( side )
    if side.respond_to?(:keys)
      parse( side )
    else
      if (/"(?<value>.)"/ =~ side.to_str)
        "'#{value}'"
      elsif (/(?<value>\d+)/ =~ side.str)
        value.to_i
      else
        side.to_str
      end
    end
  end

end