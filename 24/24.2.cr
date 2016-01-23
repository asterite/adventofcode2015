input = File.read("#{__DIR__}/input")
nums = input.lines.map(&.to_i)
sum = nums.sum
groups = 4
target_group_sum = sum / groups

def partition(nums, groups, target_group_sum, min, first)
  return true if groups == 1

  # Fetch combinations of (1..nums.size) elements
  (1..nums.size).each do |first_group_size|
    nums.each_combination(first_group_size) do |first_group|
      # If their sum is what we need
      if first_group.sum == target_group_sum
        # We check if we can partition the remaining elements
        remaining = nums - first_group
        if partition(remaining, groups - 1, target_group_sum, min, false)
          if first
            # If this is the first partition, we compute the product and save
            # it if it's less than what we have
            product = first_group.reduce(1_i64) { |m, v| m * v }
            min.value = product if product < min.value
          else
            # Otherwise, this is a second/third/etc. partition, we just need
            # to make sure we can find a partition, no need to compute a product
            return true
          end
        end
      end
    end

    # If this it the first partition and we have a minimum,
    # we are done: next iterations will try with a bigger group
    # so it can't beat this result
    return if first && min.value != Int64::MAX
  end

  nil
end

min = Int64::MAX
partition(nums, groups, target_group_sum, pointerof(min), true)
puts min
