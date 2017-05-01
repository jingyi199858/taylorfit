
#include "ppapi/cpp/var_array.h"
#include "model.h"
#include "../utils/utils.h"

/**
 * Expects a set of arrays (an array of arrays). Sets the data
 */
Model *Model::set_data(const pp::VarArray &data) {
  return set_data(data, DEFAULT_LABEL);
}

Model *Model::set_data(const pp::VarArray &data, const std::string &label) {
  data_[label] = new Matrix(data);
  fire("setData");
  return this;
}

Model *Model::set_exponents(const pp::VarArray &exponents) {
  exponents_ = tf_utils::ppvar_to_float_vec(exponents);
  fire("setExponents");
  return this;
}

Model *Model::set_multiplicands(int mults) {
  multiplicands_ = tf_utils::range(1, mults + 1);
  fire("setMultiplicands");
  return this;
}

Model *Model::set_dependent(int dependent) {
  dependent_ = dependent;
  fire("setDependent");
  return this;
}

Model *Model::set_lags(const pp::VarArray &lags) {
  lags_ = tf_utils::ppvar_to_int_vec(lags);
  fire("setLags");
  return this;
}

