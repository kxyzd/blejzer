require 'rspec'
require_relative '../lib/blejzer'

describe Blejzer::SpecificStruct do
  it 'serialization of struct' do
    Point = Struct.new(:x, :y)
    Rect  = Struct.new(:point, :size)

    source_rect = Rect.new(
      Point.new(-21_328, -2),
      987_843
    )

    blejzered_rect = Blejzer source_rect

    expect(
      Rect.typed(
        Point,
        Blejzer::Auto
      )[blejzered_rect]
    ).to eq(source_rect)
  end

  it 'serialization of user object' do
    class Node
      attr_reader :value, :left, :right

      members :value, :left, :right

      def initialize(value, left = nil, right = nil)
        @value = value
        @left = left
        @right = right
      end

      def ==(other)
        if other
          [
            other.value,
            @left == other.left,
            @right == other.right
          ].any? true
        else
          true
        end
      end
    end

    source_node = Node.new(
      54,
      Node.new(
        0,
        nil.to_s,
        Node.new(3)
      ),
      Node.new(111)
    )

    NodeType = lambda do |value|
      return value unless value.is_a? Array

      value => [value, left, right]
      Node.new(
        value,
        NodeType.call(left),
        NodeType.call(right)
      )
    end

    blejzered_node = Blejzer source_node

    expect(
      NodeType[Blejzer blejzered_node]
    ).to eq(source_node)
  end
end
